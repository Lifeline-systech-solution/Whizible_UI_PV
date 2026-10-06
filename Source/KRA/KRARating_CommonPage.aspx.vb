Imports CommonEngines.General.cEventHandlers
Public Class cKRARating_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class
Public Class cKRARating_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

Public Class cKRARating_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub



    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String 'CLSQL, CPSQL, SubTagCPSQL
        Dim strSql As String
        strSql = "SELECT EmployeeId FROM tbl_pm_employee WHERE UserName='" & CommonFunctions.General.BuildQueryString(objGlobal.UserName) & "'"
        Dim Reportingto As String
        Reportingto = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSql, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)))
        GetPageSpecificFilters += " AND (ReportingTo=" + Reportingto & " )"

    End Function
End Class
Public Class cKRARating_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class KRARating_CommonPage
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
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "KRARating_CommonList.aspx"
        MyBase.strFormPage = "KRARating_CommonPage.aspx"
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New KRARating_SubCommonPage(m_objSubTagGlobal)
    End Function
    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String


    End Function
    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    End Function
    Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    End Sub
    Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)
        Select Case UCase(Trim(Args.ClientSideFunctionName & ""))
            Case "SAVERATING"

                Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                Dim arrValueDriverID() As String = Request.Form("hdValueDriverID").Split(Convert.ToChar(","))
                Dim arrRuleID() As String = Request.Form("hdRuleID").Split(Convert.ToChar(","))
                Dim arrRating1() As String = Request.Form("Rating1").Split(Convert.ToChar(","))
                Dim arrRating2() As String = Request.Form("Rating2").Split(Convert.ToChar(","))
                Dim arrRating3() As String = Request.Form("Rating3").Split(Convert.ToChar(","))
                'Dim arrRating4() As String = Request.Form("Rating4").Split(Convert.ToChar(","))
                'Dim arrRating5() As String = Request.Form("Rating5").Split(Convert.ToChar(","))
                'Dim arrRating6() As String = Request.Form("Rating6").Split(Convert.ToChar(","))
                Dim arrWeight() As String = Request.Form("Weight").Split(Convert.ToChar(","))
                'Dim strMaxKRAAmount As String = CommonFunctions.General.CheckIsNothing(Request("MaximumKRAAmount"))
                Dim intUBound As Integer = UBound(arrValueDriverID)
                Dim intCount As Integer
                Dim sbSQL As New System.Text.StringBuilder
                Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(Request("EmployeeID"))
                Dim financialmonth As Integer
                'Dim month As Integer
                'Dim day As Integer
                'Added by manojdagde to get date from server 
                Dim tempDate As Date = Convert.ToDateTime(CommonFunctions.Data.GetDataScalar("Select GETDATE() ", True))
                'end by manojdagde
                financialmonth = 4
                'Dim currentmonth As Integer = Now.Month
                'Dim currentday As Integer = Now.Day

                Dim currentmonth As Integer = tempDate.Month
                Dim currentday As Integer = tempDate.Day
                For intCount = 0 To intUBound
                    If arrRating1(intCount) <> "" Then

                        If (arrRating1(intCount) = "") Then
                            arrRating1(intCount) = 0.ToString()
                        End If
                        If (arrRating2(intCount) = "") Then
                            arrRating2(intCount) = arrRating1(intCount)
                        End If
                        If (arrRating3(intCount) = "") Then
                            arrRating3(intCount) = arrRating2(intCount)
                        End If
                        'If (arrRating4(intCount) = "" Or arrRating4(intCount) <> arrRating3(intCount)) Then
                        '    arrRating4(intCount) = arrRating3(intCount)
                        'End If
                        'If (arrRating5(intCount) = "") Then
                        '    arrRating5(intCount) = arrRating4(intCount)
                        'End If
                        'If (arrRating6(intCount) = "") Then
                        '    arrRating6(intCount) = arrRating5(intCount)
                        'End If

                        sbSQL.Append("EXEC [dbo].[usp_Upd_tbl_KRA_EmployeeKRARating3Cycles] " + strEmployeeID + "," + arrValueDriverID(intCount) + "," + arrRuleID(intCount) + "," + arrRating1(intCount) + "," + arrRating2(intCount) + "," + arrRating3(intCount) + "," + arrWeight(intCount))
                        sbSQL.Append(vbCrLf)
                        'Dim val As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("select * from tbl_KRA_KRACalculationDate", blnUseSQL)).ToString()
                        'Dim valdate As Date = Convert.ToDateTime(val)
                        'Dim day As Integer = valdate.Day
                        'Dim month As Integer = valdate.Month

                        'If (currentmonth = month) Then
                        '    If (currentday = day) Then
                        '        sbSQL.Append("EXEC [dbo].[usp_Upd_tbl_KRA_EmployeeKRACalculation]" + strEmployeeID + "," + arrValueDriverID(intCount) + "," + arrRuleID(intCount) + "," + arrRating1(intCount) + "," + arrRating2(intCount) + "," + arrRating3(intCount) + "," + arrRating4(intCount) + "," + arrRating5(intCount) + "," + arrRating6(intCount) + "," + arrWeight(intCount) + vbCrLf)
                        '    End If
                        'End If
                    End If
                Next
                CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString(), blnUseSQL)
                sbSQL = Nothing
        End Select

    End Sub


    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cKRARating_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cKRARating_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cKRARating_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cKRARating_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overloads Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
        Return New cKRARating_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        Dim strQuery As String = "Select EmployeeName from tbl_PM_Employee where EmployeeID=" + Gen.PrimaryKeyValue
        Dim EmployeeID As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, True))
        Args.RightPageCaption = "Employee Name :" + EmployeeID
    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'If Args.ClientSideFunctionName = "SAVERATING" Then
        '    Dim strSql As String = "if (SELECT AchievedKRAAmount FROM tbl_KRA_EmployeeQuarter WHERE EmployeeID=" + HttpContext.Current.Request("EmployeeID_PK") + ") IS NULL  Select 1"
        '    Dim showLink As String = CommonFunctions.Data.GetDataScalar(strSql, True).ToString
        '    If (showLink = "1") Then
        '        Cancel = False
        '    Else
        '        Cancel = True
        '    End If


        'End If
    End Sub
End Class
Class KRARating_SubCommonPage
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim count As Integer

    Private m_sbCSScript As New System.Text.StringBuilder("")
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.New(WhizGlobal)

    End Sub
    'PROTECTED OVERRIDES SUB Before

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strDrawTextBox As String
        Dim strValueDriverID As String
        Dim strRuleID As String
        Dim strRating1 As String
        Dim strRating2 As String
        Dim strRating3 As String
        'Dim strRating4 As String
        'Dim strRating5 As String
        'Dim strRating6 As String
        Dim strDefaultWeight As String
        'Dim strMaxKRAAmount As String
        'Dim strDefaultRating As String

        Dim financialmonth As Integer
        Dim month As Integer
        Dim day As Integer
        Dim tempDate As Date = Convert.ToDateTime(CommonFunctions.Data.GetDataScalar("Select GETDATE() ", True))

        financialmonth = 4
        'month = Now.Month
        'day = Now.Day
        month = tempDate.Month
        day = tempDate.Day

        'Dim currentmonth() As String = month.Split("-".ToCharArray())
        'Dim currentday() As String = day.Split("-".ToCharArray())

        strValueDriverID = Args.DataReader("ValueDriverID").ToString
        strRuleID = Args.DataReader("RuleID").ToString
        'strDefaultWeight = CType(Args.DataReader("Weight"), String)


        Select Case UCase(Args.DataField)
            Case "CYCLE1"
                Args.IgnoreActualValue = True
                Args.ReplacementValue = ""
            Case "CYCLE2"
                Args.IgnoreActualValue = True
                Args.ReplacementValue = ""

            Case "CYCLE3"
                Args.IgnoreActualValue = True
                Args.ReplacementValue = ""
                'Case "CYCLE4"
                '    Args.IgnoreActualValue = True
                '    Args.ReplacementValue = ""
                'Case "CYCLE5"
                '    Args.IgnoreActualValue = True
                '    Args.ReplacementValue = ""
                'Case "CYCLE6"
                '    Args.IgnoreActualValue = True
                '    Args.ReplacementValue = ""

            Case "RATING1"

                'Added and Commented by PrashantD on 1 Feb 2008
                'If (month = (financialmonth + 3) Or (month = (financialmonth + 6)) Or (month = (financialmonth - 3)) Or (month = financialmonth)) Then
                If month = 2 Or month = 5 Or month = 8 Or month = 11 Then
                    'End of Addition by PrashantD on 1 Feb 2008
                    'If ((Convert.ToInt32(currentmonth(1))) = (((Convert.ToInt32(financialmonth)) + (Convert.ToInt32(6))))) Then
                    If (Convert.ToBoolean((day >= 1) And (day <= 22))) Then
                        strRating1 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating1")).ToString
                        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
                        strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating1", "Rating1", , 35, , strRating1, "Right", , False, False, , , , True, EnableHTMLEncode:=True)
                        'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("EndRange", "EndRange" + count.ToString, , 35, , strEndRange, "Right", , , , , , "onblur='validateCR_EndRange(this.id)'", True)
                        strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                        strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdRuleID", "hdRuleID", , 35, , strRuleID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                        'Plot Text box instead of grid cell value
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = strDrawTextBox

                    Else
                        strRating1 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating1")).ToString

                        'original code
                        '======
                        'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating1", "Rating1", , 35, , strRating1, "Right", , False, True, , , , True)

                        '=========
                        'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("EndRange", "EndRange" + count.ToString, , 35, , strEndRange, "Right", , , , , , "onblur='validateCR_EndRange(this.id)'", True)
                        strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                        strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdRuleID", "hdRuleID", , 35, , strRuleID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                        'ended by Shamkant s  for HTML encoding Date:07/10/15
                        'Plot Text box instead of grid cell value
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = strDrawTextBox
                        Args.ReplacementValue += "<font color=gray>" + strRating1 + "</font>"
                        Args.StringToBeInserted = "<input type=hidden name='Rating1' value=" + strRating1 + ">"
                    End If
                Else
                    strRating1 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating1")).ToString
                    'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating1", "Rating1", , 35, , strRating1, "Right", , False, True, , , , True)
                    'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("EndRange", "EndRange" + count.ToString, , 35, , strEndRange, "Right", , , , , , "onblur='validateCR_EndRange(this.id)'", True)
                    'Commented and added by Shamkant s for HTML encoding Date:07/10/15
                    strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                    strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdRuleID", "hdRuleID", , 35, , strRuleID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                    'ended by Shamkant s  for HTML encoding Date:07/10/15
                    'Plot Text box instead of grid cell value
                    Args.IgnoreActualValue = True
                    Args.ReplacementValue = strDrawTextBox
                    Args.ReplacementValue += "<font color=gray>" + strRating1 + "</font>"
                    Args.StringToBeInserted = "<input type=hidden name='Rating1' value=" + strRating1 + ">"
                End If

            Case "RATING2"
                'Added and Commented by PrashantD on 1 Feb 2008
                'If (month = (financialmonth + 4) Or (month = (financialmonth + 7)) Or (month = (financialmonth - 2)) Or (month = (financialmonth + 1))) Then
                If month = 3 Or month = 6 Or month = 9 Or month = 12 Then
                    'End of Addition by PrashantD on 1 Feb 2008

                    If (Convert.ToBoolean((day >= 1) And (day <= 10))) Then

                        strRating2 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating2")).ToString
                        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
                        strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating2", "Rating2" + count.ToString, , 35, , strRating2, "Right", , False, False, , , , True, EnableHTMLEncode:=True)
                        'ended by Shamkant s  for HTML encoding Date:07/10/15
                        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                        'Plot Text box instead of grid cell value
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = strDrawTextBox
                        'Args.ReplacementValue += "<font color=red>" + strRating2 + "</font>"
                    Else
                        strRating2 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating2")).ToString
                        'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating2", "Rating2" + count.ToString, , 35, , strRating2, "Right", , False, True, , , , True)
                        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                        'Plot Text box instead of grid cell value
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = strDrawTextBox
                        Args.ReplacementValue += "<font color=gray>" + strRating2 + "</font>"
                        Args.StringToBeInserted = "<input type=hidden name='Rating2' value=" + strRating2 + ">"
                    End If
                Else
                    strRating2 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating2")).ToString
                    'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating2", "Rating2" + count.ToString, , 35, , strRating2, "Right", , False, True, , , , True)
                    'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                    'Plot Text box instead of grid cell value
                    Args.IgnoreActualValue = True
                    Args.ReplacementValue = strDrawTextBox
                    Args.ReplacementValue += "<font color=gray>" + strRating2 + "</font>"
                    Args.StringToBeInserted = "<input type=hidden name='Rating2' value=" + strRating2 + ">"
                End If

            Case "RATING3"
                'Added and Commented by PrashantD on 1 Feb 2008
                'If (month = (financialmonth + 5) Or (month = (financialmonth + 8)) Or (month = (financialmonth - 1)) Or (month = (financialmonth + 2))) Then
                If month = 3 Or month = 6 Or month = 9 Or month = 12 Then
                    'End of Addition by PrashantD on 1 Feb 2008

                    If (Convert.ToBoolean((day >= 25) And (day <= 31))) Then
                        strRating3 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating3")).ToString
                        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
                        strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating3", "Rating3" + count.ToString, , 35, , strRating3, "Right", , False, False, , , , True, EnableHTMLEncode:=True)
                        'ended by Shamkant s  for HTML encoding Date:07/10/15
                        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                        'Plot Text box instead of grid cell value
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = strDrawTextBox
                    Else
                        strRating3 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating3")).ToString
                        'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating3", "Rating3" + count.ToString, , 35, , strRating3, "Right", , False, True, , , , True)
                        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                        'Plot Text box instead of grid cell value
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = strDrawTextBox
                        Args.ReplacementValue += "<font color=gray>" + strRating3 + "</font>"
                        Args.StringToBeInserted = "<input type=hidden name='Rating3' value=" + strRating3 + ">"

                    End If
                Else
                    strRating3 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating3")).ToString
                    'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating3", "Rating3" + count.ToString, , 35, , strRating3, "Right", , False, True, , , , True)
                    'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                    'Plot Text box instead of grid cell value
                    Args.IgnoreActualValue = True
                    Args.ReplacementValue = strDrawTextBox
                    Args.ReplacementValue += "<font color=gray>" + strRating3 + "</font>"
                    Args.StringToBeInserted = "<input type=hidden name='Rating3' value=" + strRating3 + ">"
                End If

                'Case "RATING4"
                '    If (month = (financialmonth + 7)) Then
                '        If (Convert.ToBoolean((day >= 16) And (day <= 30))) Then
                '            strRating4 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating4")).ToString
                '            strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating4", "Rating4" + count.ToString, , 35, , strRating4, "Right", , False, False, , , , True)
                '            'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '            'Plot Text box instead of grid cell value
                '            Args.IgnoreActualValue = True
                '            Args.ReplacementValue = strDrawTextBox
                '        Else
                '            strRating4 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating4")).ToString
                '            'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating4", "Rating4" + count.ToString, , 35, , strRating4, "Right", , False, True, , , , True)
                '            'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '            'Plot Text box instead of grid cell value
                '            Args.IgnoreActualValue = True
                '            Args.ReplacementValue = strDrawTextBox
                '            Args.ReplacementValue += "<font color=gray>" + strRating4 + "</font>"
                '            Args.StringToBeInserted = "<input type=hidden name='Rating4' value=" + strRating4 + ">"
                '        End If
                '    Else
                '        strRating4 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating4")).ToString
                '        'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating4", "Rating4" + count.ToString, , 35, , strRating4, "Right", , False, True, , , , True)
                '        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '        'Plot Text box instead of grid cell value
                '        Args.IgnoreActualValue = True
                '        Args.ReplacementValue = strDrawTextBox
                '        Args.ReplacementValue += "<font color=gray>" + strRating4 + "</font>"
                '        Args.StringToBeInserted = "<input type=hidden name='Rating4' value=" + strRating4 + ">"
                '    End If

                'Case "RATING5"
                '    If (month = (financialmonth + 8)) Then
                '        If (Convert.ToBoolean((day >= 1) And (day <= 15))) Then
                '            strRating5 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating5")).ToString
                '            strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating5", "Rating5" + count.ToString, , 35, , strRating5, "Right", , False, False, , , , True)
                '            'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '            'Plot Text box instead of grid cell value
                '            Args.IgnoreActualValue = True
                '            Args.ReplacementValue = strDrawTextBox

                '        Else
                '            strRating5 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating5")).ToString
                '            'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating5", "Rating5" + count.ToString, , 35, , strRating5, "Right", , False, True, , , , True)
                '            'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '            'Plot Text box instead of grid cell value
                '            Args.IgnoreActualValue = True
                '            Args.ReplacementValue = strDrawTextBox
                '            Args.ReplacementValue += "<font color=gray>" + strRating5 + "</font>"
                '            Args.StringToBeInserted = "<input type=hidden name='Rating5' value=" + strRating5 + ">"
                '        End If
                '    Else
                '        strRating5 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating5")).ToString
                '        'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating5", "Rating5" + count.ToString, , 35, , strRating5, "Right", , False, True, , , , True)
                '        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '        'Plot Text box instead of grid cell value
                '        Args.IgnoreActualValue = True
                '        Args.ReplacementValue = strDrawTextBox
                '        Args.ReplacementValue += "<font color=gray>" + strRating5 + "</font>"
                '        Args.StringToBeInserted = "<input type=hidden name='Rating5' value=" + strRating5 + ">"
                '    End If

                'Case "RATING6"
                '    If (month = (financialmonth + 8)) Then
                '        If (Convert.ToBoolean((day >= 16) And (day <= 31))) Then
                '            strRating6 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating6")).ToString
                '            strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating6", "Rating6" + count.ToString, , 35, , strRating6, "Right", , False, False, , , , True)
                '            'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '            'Plot Text box instead of grid cell value
                '            Args.IgnoreActualValue = True
                '            Args.ReplacementValue = strDrawTextBox
                '        Else
                '            strRating6 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating6")).ToString
                '            'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating6", "Rating6" + count.ToString, , 35, , strRating6, "Right", , False, True, , , , True)
                '            'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '            'Plot Text box instead of grid cell value
                '            Args.IgnoreActualValue = True
                '            Args.ReplacementValue = strDrawTextBox
                '            Args.ReplacementValue += "<font color=gray>" + strRating6 + "</font>"
                '            Args.StringToBeInserted = "<input type=hidden name='Rating6' value=" + strRating6 + ">"
                '        End If
                '    Else
                '        strRating6 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Rating6")).ToString
                '        'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Rating6", "Rating6" + count.ToString, , 35, , strRating6, "Right", , False, True, , , , True)
                '        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                '        'Plot Text box instead of grid cell value
                '        Args.IgnoreActualValue = True
                '        Args.ReplacementValue = strDrawTextBox
                '        Args.ReplacementValue += "<font color=gray>" + strRating6 + "</font>"
                '        Args.StringToBeInserted = "<input type=hidden name='Rating6' value=" + strRating6 + ">"
                '    End If

            Case "WEIGHT"
                strDefaultWeight = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Weight")).ToString
                'strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Weight", "Weight" + count.ToString, , 35, , strDefaultWeight, "Right", , False, True, , , , True)
                'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdValueDriverID", "hdValueDriverID", , 35, , strValueDriverID, "Right", , , , , True, , True)
                'Plot Text box instead of grid cell value
                Args.IgnoreActualValue = True
                Args.ReplacementValue = strDrawTextBox
                Args.ReplacementValue += "<font color=gray>" + strDefaultWeight + "</font>"
                Args.StringToBeInserted = "<input type=hidden name='Weight' value=" + strDefaultWeight + ">"
        End Select
        count = count + 1
    End Sub

    Protected Overrides Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'm_sbCSScript.Append("return true" + vbCrLf)
        'm_sbCSScript.Append("}" + vbCrLf)
        'm_sbCSScript.Append("</SCRIPT>" + vbCrLf)
        'HttpContext.Current.Response.Write(m_sbCSScript.ToString)

    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_sbCSScript.Append(vbCrLf)
        m_sbCSScript.Append("<script language=javascript>" + vbCrLf)
        m_sbCSScript.Append("function validate_orderNo()" + vbCrLf)
        m_sbCSScript.Append("{" + vbCrLf)
        'Added by SwatiM for Reducing space between action links of Subtag and action links of Common Page
        Args.DIVHeight = 350

    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'If (Args.ColumnName = "C1") Then
        Cancel = True
        '    Args.Alignment = "Center"
        '    Args.ColumnName = Now.Month.ToString()

        '    Select Case (Now.Month.ToString)
        '        Case "1"
        '            Args.ColumnName = "C1" + "(Jan)"

        '        Case "2"
        '            Args.ColumnName = "C1" + "(Feb)"

        '        Case "3"
        '            Args.ColumnName = "C1" + "(Mar)"

        '        Case "4"
        '            Args.ColumnName = "C1" + "(Apr)"

        '        Case "5"
        '            Args.ColumnName = "C1" + "(May)"

        '        Case "6"
        '            Args.ColumnName = "C1" + "(June)"

        '        Case "7"
        '            Args.ColumnName = "C1" + "(July)"

        '        Case "8"
        '            Args.ColumnName = "C1" + "(Aug)"

        '        Case "9"
        '            Args.ColumnName = "C1" + "(Sept)"

        '        Case "10"
        '            Args.ColumnName = "C1" + "(Oct)"

        '        Case "11"
        '            Args.ColumnName = "C1" + "(Nov)"

        '        Case "12"
        '            Args.ColumnName = "C1" + "(Dec)"

        '    End Select
        '    '  CommonFunctions.General.WriteHTML(" <td colspan=2> " + "Jan" + "</td>")
        'End If
        'If (Args.ColumnName = "R1" Or Args.ColumnName = "AV1") Then
        '    '     Cancel = True
        'End If

        '====================
        '        Code by swatiM



        ' Dim strValueDriverID As String
        'strValueDriverID = Args.DataReader("ValueDriverID").ToString
        'If Args.ColumnName = "C1" Then
        '    Cancel = True
        '    Args.ColumnName = Now.Month.ToString()
        '    Args.StringToBeInserted = "<td colspan=2>C1</td>"
        '    Args.Alignment = "Center"

        '    Select Case (Now.Month.ToString)
        '        Case "1"
        '            Args.ColumnName = "C1" + "(Jan)"

        '        Case "2"
        '            Args.ColumnName = "C1" + "(Feb)"

        '        Case "3"
        '            Args.ColumnName = "C1" + "(Mar)"

        '        Case "4"
        '            Args.ColumnName = "C1" + "(Apr)"

        '        Case "5"
        '            Args.ColumnName = "C1" + "(May)"

        '        Case "6"
        '            Args.ColumnName = "C1" + "(June)"

        '        Case "7"
        '            Args.ColumnName = "C1" + "(July)"

        '        Case "8"
        '            Args.ColumnName = "C1" + "(Aug)"

        '        Case "9"
        '            Args.ColumnName = "C1" + "(Sept)"

        '        Case "10"
        '            Args.ColumnName = "C1" + "(Oct)"

        '        Case "11"
        '            Args.ColumnName = "C1" + "(Nov)"

        '        Case "12"
        '            Args.ColumnName = "C1" + "(Dec)"

        '    End Select
        'End If

        '========================
        MyBase.Before_GridColumnHeaderTD_Print(Cancel, Args, WhizGlobal)

    End Sub
    Protected Overrides Sub Finalize()
        m_sbCSScript = Nothing
        MyBase.Finalize()
    End Sub

    Protected Overrides Sub After_GridColumnHeaderTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'If (Args.ColumnName = "C1" Or Args.ColumnName = "C2" Or Args.ColumnName = "C3") Then
        '    Args.StringToBeInserted = "<td colspan=2>C1</td>"
        '    Args.Alignment = "Center"
        'End If
        'If (Args.ColumnName = "AV1") Then
        '    Args.TDStyle = ""
        'End If

    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Cancel = True
    End Sub


    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)


        'Dim delim() As Char
        'delim(0) = Convert.ToChar(-)
        'Added by manoj dagde to get server date
        Dim tempDate As Date = Convert.ToDateTime(CommonFunctions.Data.GetDataScalar("Select GETDATE() ", True))
        'end by manoj dagde
        Dim financialMonth As String

        'Dim currentMonth As String = Now.AddMonths(0).ToString("dd-MMM-yyyy")
        'Dim CurrentmonthName() As String = currentMonth.Split("-".ToCharArray())
        Dim currentMonth As String = tempDate.AddMonths(0).ToString("dd-MMM-yyyy")
        Dim CurrentmonthName() As String = currentMonth.Split("-".ToCharArray())

        'get name of next month in quarter
        Dim nextMonth As String = tempDate.AddMonths(1).ToString("dd-MMM-yyyy")
        Dim NextmonthName() As String = nextMonth.Split("-".ToCharArray())
        Dim nextMonth1 As String = tempDate.AddMonths(2).ToString("dd-MMM-yyyy")
        Dim Nextmonth1Name() As String = nextMonth1.Split("-".ToCharArray())

        '==================
        '        Plot(header)
        '=====================
        'CommonFunctions.General.WriteHTML("<div id='divListTag' style='overflow-x:auto;width:99.9%;z-index=2;height:px;'  >")

        Dim month() As String = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
        Dim cnt As Integer
        cnt = 0
        'If (Now.Month >= 10 And Now.Month <= 12) Then
        If (tempDate.Month >= 10 And tempDate.Month <= 12) Then
            cnt = 9
            ' ElseIf (Now.Month >= 1 And Now.Month <= 3) Then
        ElseIf (tempDate.Month >= 1 And tempDate.Month <= 3) Then
            cnt = 0
            'ElseIf (Now.Month >= 4 And Now.Month <= 6) Then
        ElseIf (tempDate.Month >= 4 And tempDate.Month <= 6) Then
            cnt = 3
            'ElseIf (Now.Month >= 7 And Now.Month <= 9) Then
        ElseIf (tempDate.Month >= 7 And tempDate.Month <= 9) Then
            cnt = 6
        End If

        CommonFunctions.General.WriteHTML("<table id='tblGrid03883' width='99.9%'  CellSpacing=0 CellPadding=0  class='clsGridTable' >")
        CommonFunctions.General.WriteHTML("<thead class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<th class=divListTag_Column >ValueDriver</th>")
        CommonFunctions.General.WriteHTML("<th class=divListTag>Rule</th>")
        CommonFunctions.General.WriteHTML("<th class=divListTag>Wt.</th>")
        CommonFunctions.General.WriteHTML("<td>  </td>")
        CommonFunctions.General.WriteHTML("<th class=divListTag colspan=2 align=center>C1 (" + month(cnt) + ")</th>")

        CommonFunctions.General.WriteHTML("<td>  </td>")
        CommonFunctions.General.WriteHTML("<th class=divListTag colspan=2 align=center>C2 (" + month(cnt + 1) + ")</th>")
        CommonFunctions.General.WriteHTML("<td>  </td>")
        CommonFunctions.General.WriteHTML("<th class=divListTag  colspan=2 align=center>C3 (" + month(cnt + 2) + ")</th>")
        'CommonFunctions.General.WriteHTML("<td>  </td>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  colspan=2 align=center>C4 (" + month(cnt + 1) + ")</th>")
        'CommonFunctions.General.WriteHTML("<td>  </td>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  colspan=2 align=center>C5 (" + month(cnt + 2) + ")</th>")
        'CommonFunctions.General.WriteHTML("<td>  </td>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  colspan=2 align=center>C6 (" + month(cnt + 2) + ")</th>")
        CommonFunctions.General.WriteHTML("</thead>")
        CommonFunctions.General.WriteHTML("<thead class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<th class=divListTag_Column ></th>")
        CommonFunctions.General.WriteHTML("<th class=divListTag ></th>")
        CommonFunctions.General.WriteHTML("<th class=divListTag ></th>")
        CommonFunctions.General.WriteHTML("<td>  </td>")
        CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>R1</th>")
        CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>AV1</th>")
        CommonFunctions.General.WriteHTML("<td>  </td>")
        CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>R2</th>")
        CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>AV2</th>")
        CommonFunctions.General.WriteHTML("<td>  </td>")
        CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>R3</th>")
        CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>AV3</th>")
        'CommonFunctions.General.WriteHTML("<td>  </td>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>R4</th>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>AV4</th>")
        'CommonFunctions.General.WriteHTML("<td>  </td>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>R5</th>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>AV5</th>")
        'CommonFunctions.General.WriteHTML("<td>  </td>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>R6</th>")
        'CommonFunctions.General.WriteHTML("<th class=divListTag  align=center>AV6</th>")
        CommonFunctions.General.WriteHTML("</thead>")

        'If (Args.clsColumnHeader = "C1") Then
        '    Args.clsColumnHeader = "C1" + Now.Month.ToString()
        'End If

    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_sbCSScript.Append("return true" + vbCrLf)
        m_sbCSScript.Append("}" + vbCrLf)
        m_sbCSScript.Append("</SCRIPT>" + vbCrLf)
        HttpContext.Current.Response.Write(m_sbCSScript.ToString)
    End Sub
End Class
'#Region "Grid_Class"

'Class Display_Grid

'    Inherits Whiz.CommonEngine.CommonList.cPlotGrid

'    Public Sub New(ByVal Global1 As WebPages.Template.IGlobal)

'        Call MyBase.New(Global1)

'    End Sub

'    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

'        'MyBase.Before_GridDataRowTR_Print(Cancel, Args, WhizGlobal)

'    End Sub

'    Protected Overrides Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

'        'MyBase.After_GridDataRowTD_Print(Args, WhizGlobal)

'    End Sub



'    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

'        'MyBase.Before_GridDataRowTD_Print(Cancel, Args, WhizGlobal)

'    End Sub

'End Class

'#End Region



