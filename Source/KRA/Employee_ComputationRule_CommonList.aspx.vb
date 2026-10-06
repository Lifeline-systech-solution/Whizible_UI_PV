Imports CommonEngines.General.cEventHandlers


Public Class Employee_ComputationRule_CommonList
    Inherits CommonList
    Public Shared ISflag As Boolean
    Dim count As Integer


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "Employee_ComputationRule_CommonList.aspx"
        MyBase.strFormPage = "Employee_ComputationRule_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region


    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim intEmployeeID As Integer
        Dim intQuarterID As Integer
        Dim intRuleID As Integer
        Dim intValueDriverID As Integer
        Dim intEmployeeKRAID As Integer
        If HttpContext.Current.Request.QueryString("select") = "True" Then
            Dim strRuleID() As String
            Dim i As Integer
            Dim strEmployeeID() As String
            Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect"))
            Dim STR() As String
            Dim strQuarterID() As String
            Dim RuleID() As String
            Dim strValueDriverID() As String
            Dim strEmployeeKRAID() As String

            'Take  IDs into array in comma seperated format
            strRuleID = strRequiredIDArray.Split(Convert.ToChar(","))
            ''''--
            strEmployeeID = HttpContext.Current.Request.QueryString.GetValues("EmployeeID")
            strQuarterID = HttpContext.Current.Request.QueryString.GetValues("QuarterID")
            RuleID = HttpContext.Current.Request.QueryString.GetValues("RuleID")
            strValueDriverID = HttpContext.Current.Request.QueryString.GetValues("ValueDriverID")
            strEmployeeKRAID = HttpContext.Current.Request.QueryString.GetValues("EmployeeKRAID")

            '''''''''
            intEmployeeID = Convert.ToInt32(strEmployeeID(0))
            intQuarterID = Convert.ToInt32(strQuarterID(0))
            intRuleID = Convert.ToInt32(RuleID(0))
            intValueDriverID = Convert.ToInt32(strValueDriverID(0))
            intEmployeeKRAID = Convert.ToInt32(strEmployeeKRAID(0))

            'For Deleting Already Exist record from tbl_KRA_EmployeeRule
            Dim sbSqlDel As New System.Text.StringBuilder
            Dim strSqlDel As String
            ' strSqlDel = "usp_Del_tbl_KRA_EmployeeRule " & Convert.ToInt32(RuleID(0)) & "," & intEmployeeID & "," & intQuarterID & "," & intValueDriverID
            ' CommonFunction.Data.InsertOrUpdateData(strSqlDel, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            strSqlDel = Nothing

            'For Inserting New Record into tbl_KRA_EmployeeRule
            Dim sbSQL As New System.Text.StringBuilder
            'For loop to pass value drivers ids from ValDrvID array to selected RoleID
            For i = 0 To strRuleID.Length - 1


                Dim strSQL As String
                strSQL = "usp_Ins_tbl_KRA_EmployeeRule " & Convert.ToInt32(strRuleID(i)) & "," & intEmployeeID & "," & intQuarterID & "," & intValueDriverID & ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                strSQL = Nothing
            Next

            Dim strQuery As String = "usp_UPD_tbl_KRA_EmployeeKRARule " & intEmployeeKRAID & "," & Convert.ToInt32(strRuleID(0)) & ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
            CommonFunction.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            strQuery = Nothing
            'sbSQL.Append("EXEC [dbo].usp_UPD_tbl_KRA_EmployeeKRARule " & intEmployeeID & "," & intQuarterID & "," & Convert.ToInt32(strRuleID(0)) & "," & intValueDriverID & ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'")

            'sbSQL.Append("EXEC [dbo].usp_UPD_tbl_KRA_EmployeeKRARule " & intEmployeeKRAID & "," & Convert.ToInt32(strRuleID(0)) & ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'")
            'To Refresh the parent page with selected value drivers and close the child window 
            CommonFunction.General.WriteHTML(vbCrLf + "<Script language=javascript>")
            CommonFunction.General.WriteHTML(vbCrLf + "   refreshParent('frmCommonPage','KRA_Employee_Inherit_CommonPage.aspx','../../Source/KRA/KRA_Employee_Inherit_CommonPage.aspx');")
            CommonFunction.General.WriteHTML(" window.close();")
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End If


        If HttpContext.Current.Request.QueryString("Action") = "save" Then
            Dim Rule As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("RuleID_PK"))

            CommonFunction.General.WriteHTML(vbCrLf + "<script language=javascript>")
            CommonFunction.General.WriteHTML(vbCrLf + "windows.open( Employee_ComputationRule_CommonPage.aspx?MasterTagID=3896&RuleID_PK=" & Rule & ");")
            'CommonFunction.General.WriteHTML(" window.close();")
            CommonFunction.General.WriteHTML("</SCRIPT>")

            'Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/Employee_ComputationRule_CommonPage.aspx?MasterTagID=30084&RuleID_PK=" & Rule & "&Action=save"";"
            'Args.ToBeInsertedInFunction += "objfrm.submit(); return;"

        End If




        '==========================================================================================================
        'Ended by   : MANOJ DAGDE
        'Date       : 12 Oct 2007
        '==============================================
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function


    Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim intEmployeeID As Integer
        Dim intRuleID As Integer
        Dim intQuarterID As Integer
        Dim intValueDriverID As Integer
        Dim intEmployeeKRAID As Integer

        '       If Not HttpContext.Current.Request.QueryString("EmployeeID")) Then
        '            Session("sEmployeeID") = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"))
        '      End If


        If Not HttpContext.Current.Request.QueryString("EmployeeID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("EmployeeID") <> "" Then
            Session("sEmployeeID") = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"))
            CommonFunction.General.WriteHTML("<Input type=hidden name=hidEmployeeID value=" + HttpContext.Current.Request.QueryString("EmployeeID") + ">")

        ElseIf Not HttpContext.Current.Request.Form("hidEmployeeID") Is Nothing AndAlso HttpContext.Current.Request.Form("hidEmployeeID") <> "" Then

            CommonFunction.General.WriteHTML("<Input type=hidden name=hidEmployeeID value=" + HttpContext.Current.Request.Form("hidEmployeeID") + ">")

        End If


        If Not HttpContext.Current.Request.QueryString("RuleID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("RuleID") <> "" Then
            Session("sRuleID") = HttpContext.Current.Request.QueryString("RuleID")
            CommonFunction.General.WriteHTML("<Input type=hidden name=hidRuleID value=" + HttpContext.Current.Request.QueryString("RuleID") + ">")

        ElseIf Not HttpContext.Current.Request.Form("hidRuleID") Is Nothing AndAlso HttpContext.Current.Request.Form("hidRuleID") <> "" Then

            CommonFunction.General.WriteHTML("<Input type=hidden name=hidRuleID value=" + HttpContext.Current.Request.Form("hidRuleID") + ">")

        End If


        If Not HttpContext.Current.Request.QueryString("QuarterID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("QuarterID") <> "" Then
            Session("sQuarterID") = HttpContext.Current.Request.QueryString("QuarterID")
            CommonFunction.General.WriteHTML("<Input type=hidden name=hidQuarterID value=" + HttpContext.Current.Request.QueryString("QuarterID") + ">")

        ElseIf Not HttpContext.Current.Request.Form("hidQuarterID") Is Nothing AndAlso HttpContext.Current.Request.Form("hidQuarterID") <> "" Then

            CommonFunction.General.WriteHTML("<Input type=hidden name=hidQuarterID value=" + HttpContext.Current.Request.Form("hidQuarterID") + ">")

        End If


        If Not HttpContext.Current.Request.QueryString("ValueDriverID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("ValueDriverID") <> "" Then
            Session("sValueDriverID") = HttpContext.Current.Request.QueryString("ValueDriverID")
            CommonFunction.General.WriteHTML("<Input type=hidden name=hidValueDriverID value=" + HttpContext.Current.Request.QueryString("ValueDriverID") + ">")

        ElseIf Not HttpContext.Current.Request.Form("hidValueDriverID") Is Nothing AndAlso HttpContext.Current.Request.Form("hidValueDriverID") <> "" Then

            CommonFunction.General.WriteHTML("<Input type=hidden name=hidValueDriverID value=" + HttpContext.Current.Request.Form("hidValueDriverID") + ">")

        End If


        'If Not HttpContext.Current.Request.QueryString("EmployeeKRAID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("EmployeeKRAID") <> "" Then

        '    CommonFunction.General.WriteHTML("<Input type=hidden name=hidEmployeeKRAID value=" + HttpContext.Current.Request.QueryString("EmployeeKRAID") + ">")

        'ElseIf Not HttpContext.Current.Request.Form("hidEmployeeKRAID") Is Nothing AndAlso HttpContext.Current.Request.Form("hidEmployeeKRAID") <> "" Then

        '    CommonFunction.General.WriteHTML("<Input type=hidden name=hidEmployeeKRAID value=" + HttpContext.Current.Request.Form("hidEmployeeKRAID") + ">")

        'End If



        If Not HttpContext.Current.Request.QueryString("EmployeeKRAID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("EmployeeKRAID") <> "" Then
            Session("sEmployeeKRAID") = HttpContext.Current.Request.QueryString("EmployeeKRAID")
            CommonFunction.General.WriteHTML("<Input type=hidden name=hidEmployeeKRAID value=" + HttpContext.Current.Request.QueryString("EmployeeKRAID") + ">")

        ElseIf Not HttpContext.Current.Request.Form("hidEmployeeKRAID") Is Nothing AndAlso HttpContext.Current.Request.Form("hidEmployeeKRAID") <> "" Then

            CommonFunction.General.WriteHTML("<Input type=hidden name=hidEmployeeKRAID value=" + HttpContext.Current.Request.Form("hidEmployeeKRAID") + ">")

        End If


        Select Case Args.ClientSideFunctionName
            Case "ADD_NEW"
                Cancel = True

                'iF SAVEVALUE Link 
            Case "ApplyRule"
                If Args.ClientSideFunctionName = "ApplyRule" Then
                    Dim strEmployeeID As String
                    Dim strQuarterID As String
                    Dim strRuleID As String
                    Dim strValueDriverID As String
                    Dim strEmployeeKRAID As String

                    ''Dim strCommonString() As String
                    ''Dim strCatch As String
                    ''Dim i As Integer

                    ''strCommonString = Args.CommonQueryString.Split("&".ToCharArray())
                    ''For i = 0 To strCommonString(i).Length
                    ''    If strCommonString(i).StartsWith("EmployeeID") Then
                    ''        strCatch = strCommonString(i).Substring(strCommonString(i).IndexOf("=") + 1)
                    ''        strEmployeeID = strCatch
                    ''        Exit For
                    ''    End If
                    ''Next

                    ''For i = 0 To strCommonString(i).Length
                    ''    If strCommonString(i).StartsWith("QuarterID") Then
                    ''        strCatch = strCommonString(i).Substring(strCommonString(i).IndexOf("=") + 1)
                    ''        strQuarterID = strCatch
                    ''        Exit For
                    ''    End If
                    ''Next


                    ''For i = 0 To strCommonString(i).Length
                    ''    If strCommonString(i).StartsWith("RuleID") Then
                    ''        strCatch = strCommonString(i).Substring(strCommonString(i).IndexOf("=") + 1)
                    ''        strRuleID = strCatch
                    ''        Exit For
                    ''    End If
                    ''Next


                    ''For i = 0 To strCommonString(i).Length
                    ''    If strCommonString(i).StartsWith("ValueDriverID") Then
                    ''        strCatch = strCommonString(i).Substring(strCommonString(i).IndexOf("=") + 1)
                    ''        strRuleID = strCatch
                    ''        Exit For
                    ''    End If
                    ''Next


                    ''For i = 0 To strCommonString(i).Length
                    ''    If strCommonString(i).StartsWith("EmployeeKRAID") Then
                    ''        strCatch = strCommonString(i).Substring(strCommonString(i).IndexOf("=") + 1)
                    ''        strEmployeeKRAID = strCatch
                    ''        Exit For
                    ''    End If
                    ''Next

                    'CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("UniqueID"))

                    strEmployeeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("EmployeeID"))
                    If strEmployeeID = "" Then
                        Dim strEmpID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("hidEmployeeID"))
                        Dim strVal1() As String = strEmpID.Split(Convert.ToChar(","))
                        'strEmployeeID = strVal1(0)
                        strEmployeeID = CType(HttpContext.Current.Session("sEmployeeID"), String) 'CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("sEmployeeID"))
                    End If

                    strQuarterID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("QuarterID"))
                    If strQuarterID = "" Then
                        Dim strEmpID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("hidQuarterID"))
                        Dim strVal() As String = strEmpID.Split(Convert.ToChar(","))
                        '                        strQuarterID = strVal(0)
                        strQuarterID = CType(HttpContext.Current.Session("sQuarterID"), String) 'CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("sQuarterID"))
                    End If

                    strRuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("RuleID"))
                    If strRuleID = "" Then
                        Dim strEmpID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("hidRuleID"))
                        Dim strVal() As String = strEmpID.Split(Convert.ToChar(","))
                        'strRuleID = strVal(0)
                        strRuleID = CType(HttpContext.Current.Session("sRuleID"), String) 'CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("sRuleID"))
                    End If

                    strValueDriverID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ValueDriverID"))
                    If strValueDriverID = "" Then
                        Dim strEmpID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("hidValueDriverID"))
                        Dim strVal() As String = strEmpID.Split(Convert.ToChar(","))
                        'strValueDriverID = strVal(0)
                        strValueDriverID = CType(HttpContext.Current.Session("sValueDriverID"), String) 'CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("sValueDriverID"))
                    End If

                    strEmployeeKRAID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("EmployeeKRAID"))
                    If strEmployeeKRAID = "" Then
                        Dim strEmpID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("hidEmployeeKRAID"))
                        Dim strVal() As String = strEmpID.Split(Convert.ToChar(","))
                        'strEmployeeKRAID = strVal(0)
                        strEmployeeKRAID = CType(HttpContext.Current.Session("sEmployeeKRAID"), String) 'CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("sEmployeeKRAID = "))
                    End If

                    intEmployeeID = Convert.ToInt32(strEmployeeID)
                    intQuarterID = Convert.ToInt32(strQuarterID)
                    intRuleID = Convert.ToInt32(strRuleID)
                    intValueDriverID = Convert.ToInt32(strValueDriverID)
                    intEmployeeKRAID = Convert.ToInt32(strEmployeeKRAID)

                    Args.ToBeInsertedInFunction = "var objRuleID = GetObjectReference('frmCommonList','RuleID');"
                    Args.ToBeInsertedInFunction += "var objChkSelect = GetObjectReference('frmCommonList','chkSelect',true);"
                    'Args.ToBeInsertedInFunction += "alert(intUniqueID);"
                    'Args.ToBeInsertedInFunction += "for(icount=0;icount<objChkDelete.length;icount++)  {"
                    'Args.ToBeInsertedInFunction += " if(objChkDelete[icount].checked==true)   break; }"
                    'Args.ToBeInsertedInFunction += "if(icount==objChkDelete.length) {"
                    'Args.ToBeInsertedInFunction += "alert('Please select at least one record');  return;  }"
                    'Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/Employee_ComputationRule_CommonList.aspx?MasterTagID=30084&EmployeeID=" & intEmployeeID & "&QuarterID=" & intQuarterID & "&select=True"";"
                    Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/Employee_ComputationRule_CommonList.aspx?MasterTagID=3896&EmployeeID=" & intEmployeeID & "&QuarterID=" & intQuarterID & "&RuleID=" & intRuleID & "&ValueDriverID=" & intValueDriverID & "&EmployeeKRAID=" & intEmployeeKRAID & "&select=True"";"
                    'Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/SelectValueDriver_CommonList.aspx?MasterTagID=30063&Action=save"";"
                    Args.ToBeInsertedInFunction += "objfrm.submit(); return;"
                End If

                'Case "ADDCR"
                '    If Args.ClientSideFunctionName = "ADDCR" Then

                '        Dim strRule As String = " Select Max(RuleID) From tbl_KRA_ComputationRule_Master "
                '        Dim Rule As String = CommonFunction.Data.GetDataScalar(strRule, True).ToString
                '        Dim strQuery1 As String = "Select RuleDescription From tbl_KRA_ComputationRule_Master where RuleID =" + Rule
                '        'Where(EmployeeID = " + strEmployeeID + " And QuarterID = " + strQuarterID + " And RuleID = " + strRuleID + " And ValueDriverID = " + strValueDriverID")
                '        Dim strDescription As String = CommonFunction.Data.GetDataScalar(strQuery1, True).ToString


                '        Args.ToBeInsertedInFunction = "var objRuleID = GetObjectReference('frmCommonList','RuleID');"
                '        Args.ToBeInsertedInFunction += "var objChkSelect = GetObjectReference('frmCommonList','chkSelect',true);"

                '        'Args.ToBeInserted = "<A HREF='../../Source/KRA/EmployeeRule_CommonPage.aspx?MasterTagID=30084&RuleID_PK=" + strRule + "'>" + strDescription + "</a>"
                '        'Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/Employee_ComputationRule_CommonPage.aspx?MasterTagID=30084&EmployeeID=" & intEmployeeID & "&QuarterID=" & intQuarterID & "&RuleID=" & intRuleID & "&ValueDriverID=" & intValueDriverID & "&EmployeeKRAID=" & intEmployeeKRAID & "&select=True"";"
                '        Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/Employee_ComputationRule_CommonList.aspx?MasterTagID=30084&RuleID_PK=" & Rule & "&Action=save"";"
                '        Args.ToBeInsertedInFunction += "objfrm.submit(); return;"
                '    End If
            Case "ADDCR"
                ISflag = True
        End Select

        'If Not HttpContext.Current.Request.QueryString("EmployeeKRAID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("EmployeeKRAID") <> "" Then

        '    CommonFunction.General.WriteHTML("<Input type=hidden name=hidEmployeeKRAID value=" + HttpContext.Current.Request.QueryString("EmployeeKRAID") + ">")

        'ElseIf Not HttpContext.Current.Request.Form("hidEmployeeKRAID") Is Nothing AndAlso HttpContext.Current.Request.Form("hidEmployeeKRAID") <> "" Then

        '    CommonFunction.General.WriteHTML("<Input type=hidden name=hidEmployeeKRAID value=" + HttpContext.Current.Request.Form("hidEmployeeKRAID") + ">")

        'End If


        'Args.ToBeInsertedInFunction += CommonFunctions.HTMLControls.DrawTextBox("EmployeeKRAID", "EmployeeKRAID", , , , HttpContext.Current.Request("EmployeeKRAID"), , , , True, , True, , True, False, , , )
        '==========================================================================================================
        'Ended by   : MANOJ DAGDE
        'Date       : 22 Oct 2007
        '===========================================================================================================

    End Sub

    Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New Employee_Computation_Rule_FormatGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New Employee_Computation_Rule_CommonListCLSQL(MyBase.m_objGlobal)
    End Function
End Class
Class Employee_Computation_Rule_FormatGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim count As Integer
    Private m_sbCSScript As New System.Text.StringBuilder("")
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.New(WhizGlobal)

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Dim flag As Boolean
        Dim strDrawCheckBox As String
        '  Dim strRuleID As String
        Dim strStartRange As String
        Dim strEndRange As String
        Dim strAppliedValue As String
        Dim strString As String

        'Dim flag As New Employee_ComputationRule_CommonList
        Select Case UCase(Args.ColumnName)


            Case "RULEDESCRIPTION"

                Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeID"))
                Dim strQuarterID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("QuarterID"))
                Dim strRuleID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("RuleID"))
                Dim strValueDriverID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ValueDriverID"))

                If Args.DataReader("IsAssignedToRole").ToString = "1" Then
                    'IF(
                    '    ' Dim strDescription As String = Args.DataReader("RuleDescription").ToString
                    '    'Dim strEmployeeRuleID As String = Args.DataReader("EmployeeRuleID").ToString
                    'If Employee_ComputationRule_CommonList.ISflag = True Then

                    'Dim strQuery As String = "Select MAX(RuleID) From tbl_KRA_ComputationRule_Master"
                    'Dim strEmployeeRuleID As String = CommonFunction.Data.GetDataScalar(strQuery, True).ToString

                    'Dim strQuery1 As String = "Select RuleDescription From tbl_KRA_ComputationRule_Master Where RuleID=" + strEmployeeRuleID
                    'Dim strDescription As String = CommonFunction.Data.GetDataScalar(strQuery1, True).ToString
                    'Args.IgnoreActualValue = True
                    'Args.ReplacementValue = "<A HREF='../../Source/KRA/Employee_ComputationRule_CommonPage.aspx?MasterTagID=30084&RuleID_PK=" + strEmployeeRuleID + "'>" + strDescription + "</a>"
                    'Employee_ComputationRule_CommonList.ISflag = False
                    'End If
                End If

            Case "SELECT"

                Cancel = True
                'strRuleID = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RuleID")).ToString

                ' strDrawCheckBox = "<TD>"
                'strDrawCheckBox += CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect" + count.ToString, , , , , "onClick='DeSelect(this.id)'", True)
                If Args.DataReader("IsAssignedToRole").ToString = "1" Then

                    strDrawCheckBox += CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , True, Args.DataReader("ruleid").ToString, , "onClick='DeSelect(this)'", True)
                    'Args.EnableLink = True

                    'Args.StringToBeInserted = "<A HREF='../../Source/KRA/EmployeeRule_CommonPage.aspx?MasterTagID=30129'>" + Args.DataReader("RuleDescription").ToString + "</a>"
                    'strDrawCheckBox += CommonFunctions.HTMLControls.DrawCheckBox("hdRuleID", "hdRuleID", , , strRuleID)
                Else
                    strDrawCheckBox += CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , Args.DataReader("ruleid").ToString, , "onClick='DeSelect(this)'", True)

                End If

                Args.StringToBeInserted = "<TD>" + strDrawCheckBox + "</TD>"
                Args.IgnoreActualValue = True
                Args.ReplacementValue = strDrawCheckBox

                ' Args.StringToBeInserted = " onClick='DeSelect(this.id)'"

        End Select
        count = count + 1




    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Select Case UCase(Args.CaptionForDeleteColumn)

        '    Case "SELECT"

        '        Args.ToBeInserted = "<script langauage='javascript'>"
        '        Args.ToBeInserted += "var objCompanyName = GetObjectReference('frmCommonList','chkdelete');"

        'End Select

        'Case "SAVEVALUE"

        '        Dim STR() As String
        '        Dim strQuerterID() As String

        '        STR = HttpContext.Current.Request.QueryString.GetValues("UniqueID")
        '        strQuerterID = HttpContext.Current.Request.QueryString.GetValues("QuarterID")

        '        intEmployeeID = Convert.ToInt32(STR(0))
        '        intQuarterID = Convert.ToInt32(strQuerterID(0))

        '        If Args.ClientSideFunctionName = "SAVEVALUE" Then
        '            Args.ToBeInsertedInFunction = "var objCompanyName = GetObjectReference('frmCommonList','ValueDriverID');"
        '            Args.ToBeInsertedInFunction += "var objChkDelete = GetObjectReference('frmCommonList','chkDelete',true);"
        '            Args.ToBeInsertedInFunction += "var icount;"
        '            Args.ToBeInsertedInFunction += "for(icount=0;icount<objChkDelete.length;icount++)  {"
        '            Args.ToBeInsertedInFunction += " if(objChkDelete[icount].checked==true)   break; }"
        '            Args.ToBeInsertedInFunction += "if(icount==objChkDelete.length) {"
        '            Args.ToBeInsertedInFunction += "alert('Please select at least one record');  return;  }"
        '            Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/Select_ValueDriver_Employee_Inherit_CommonList.aspx?MasterTagID=30063&UniqueID=" & intEmployeeID & "&QuerterID=" & intQuarterID & "&select=True"";"
        '            'Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/SelectValueDriver_CommonList.aspx?MasterTagID=30063&Action=save"";"
        '            Args.ToBeInsertedInFunction += "objfrm.submit(); return;"
        'End If


        m_sbCSScript.Append("return true" + vbCrLf)
        m_sbCSScript.Append("}" + vbCrLf)
        m_sbCSScript.Append("</SCRIPT>" + vbCrLf)
        HttpContext.Current.Response.Write(m_sbCSScript.ToString)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_sbCSScript.Append(vbCrLf)
        m_sbCSScript.Append("<script language=javascript>" + vbCrLf)
        m_sbCSScript.Append("function validate_orderNo()" + vbCrLf)
        m_sbCSScript.Append("{" + vbCrLf)
    End Sub

    Protected Overrides Sub Finalize()
        m_sbCSScript = Nothing
        MyBase.Finalize()
    End Sub

    Protected Overrides Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''If UCase(Args.ColumnName) = "SELECT" Then
        ''    Args.StringToBeInserted = "<TD></TD>"
        ''End If
    End Sub
End Class



'=====================================================================
' Class Name	        :	Employee_Computation_Rule_CommonListCLSQL
' Purpose				:	To show RULE already assign to Employee 
' Description			:	as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	MANOJ DAGDE
' Created				:	24-oct-2007
' Revisions				:	
'=====================================================================

#Region "Grid_Class"
Public Class Employee_Computation_Rule_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Use the Stored Procedure instead of the dynamic SQL for these web forms to avoid the
        ' Args.GridSQL = "exec usp_Sel_tbl_KRA_ComputationRule_Master_ForEmployee  " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeID"))

        'Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeID"))
        'Dim strQuarterID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("QuarterID"))
        'Dim strRuleID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("RuleID"))
        'Dim strValueDriverID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ValueDriverID"))

        'Dim Str As String
        'Str = Args.CommonQueryString.Split("&".ToCharArray())
        'For i = 0 To Str(i).Length
        '    If Str(i).StartsWith("RoleID") Then
        '        strCatch = Str(i).Substring(Str(i).IndexOf("=") + 1)
        '        strRoleIDtemp = strCatch
        '        Exit For
        '    End If
        'Next

        Dim strEmployeeKRAID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeKRAID"))
        If strEmployeeKRAID = "" Then
            Dim kraid As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("hidEmployeeKRAID"))
            Dim strVal() As String = kraid.Split(Convert.ToChar(","))

            Args.GridSQL = "exec usp_Sel_tbl_KRA_EmployeeKRA_Master_ForEmployeeRule  " + CType(HttpContext.Current.Session("sEmployeeKRAID"), String) 'strVal(0).ToString
        Else
            Args.GridSQL = "exec usp_Sel_tbl_KRA_EmployeeKRA_Master_ForEmployeeRule  " + strEmployeeKRAID
        End If
        ' Args.GridSQL = "exec usp_Sel_tbl_KRA_EmployeeKRA_Master_ForEmployeeRule  " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeKRAID")) + "," + strEmployeeID + "," + strQuarterID + "," + strRuleID + "," + strValueDriverID
    End Sub


    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        ' GetPageSpecificFilters += " AND (Owner=" + objGlobal.UserID.ToString & " OR Owner=NULL & ")"
        GetPageSpecificFilters += " AND (Owner=" + objGlobal.UserID.ToString & " OR Owner=Null)"
    End Function
End Class
#End Region
