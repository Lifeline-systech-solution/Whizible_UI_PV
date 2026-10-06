Imports CommonEngines.General.cEventHandlers
Public Class CRM_ConfigureRequestType_CommonList
    Inherits CommonList

    Dim m_strDepartmentID As String = ""
    Dim m_strRequestTypeID As String = ""



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

        'Addition done by SuchitraP on 30-MAY-2007 for HelpDesk
        Dim strAction As String
        Dim strCheckbox As String
        Dim strCheckboxArray() As String
        Dim strSeperatorArray() As String
        Dim strFunctionID As String
        Dim strRequestTypeID As String
        Dim intIterator As Integer
        Dim intCounter As Integer
        Dim strSQL As String = ""
        Dim i As Integer
        'Added by ShraddhaM on 29,Aug 2008
        'ReporingTo Approval against subRequestType
        Dim chkApproval As String
        Dim arrchkApproval() As String
        Dim j As Integer
        'End of addition by ShraddhaM on 29,Aug 2008

        strAction = Request.QueryString("Action")

        If strAction = "Map" Then
            strFunctionID = Request.Form("cboDepartmentID")
            If strFunctionID Is Nothing OrElse strFunctionID = "" Then
                'strFunctionID = Request.QueryString("FunctionID")
                strFunctionID = "NULL"
            End If
            strRequestTypeID = Request.Form("cboRequestTypeID")
            If strRequestTypeID Is Nothing OrElse strRequestTypeID = "" Then
                strRequestTypeID = "NULL"
            End If

            'If strFunctionID Is Nothing AndAlso strFunctionID = "" Then
            'Else
            If Not strFunctionID Is Nothing Then
                strSQL = "EXEC usp_Del_tbl_CRM_Function_RequestTypes_Mapping " + strFunctionID + "," + strRequestTypeID
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                strCheckbox = Request.Form("chkDelete")
                'Addition done by SuchitraP on 4-JUN-2007 for IssueID 13458
                If Not strCheckbox Is Nothing Then
                    'End of Addition done by SuchitraP on 4-JUN-2007 for IssueID 13458
                    strCheckboxArray = strCheckbox.Split(CType(",", Char))


                    For intIterator = 0 To strCheckboxArray.Length - 1
                        strSeperatorArray = strCheckboxArray(intIterator).Split(CType("|", Char))
                        For i = 0 To strSeperatorArray.Length - 1
                            If strSeperatorArray(i) = "" Then
                                strSeperatorArray(i) = "NULL"
                            Else
                                strSeperatorArray(i) = strSeperatorArray(i).Replace("$~", ",")
                                strSeperatorArray(i) = CommonFunction.General.BuildQueryString(strSeperatorArray(i))
                            End If
                            'strSQL = "EXEC usp_Ins_tbl_CRM_Function_RequestTypes_Mapping " + strFunctionID + "," + strSeperatorArray(0) + "," + strSeperatorArray(1)
                        Next

                        'Modified by ShraddhaM on 9,Sept 2008
                        'Purpose : For Line Manager Approval Functionality in Whiziblesem8
                        chkApproval = CType(Request.Form("chkApproval" + strSeperatorArray(0)), String)
                        If Not chkApproval Is Nothing And chkApproval <> "" Then
                            arrchkApproval = chkApproval.Split(CType(",", Char))
                        End If
                        If Not chkApproval Is Nothing And chkApproval <> "" Then
                            If chkApproval.Contains(strSeperatorArray(1)) Then
                                'strSQL = "EXEC usp_Ins_tbl_CRM_Function_RequestTypes_Mapping " + strFunctionID + "," + strSeperatorArray(0) + "," + strSeperatorArray(1) + "," + IIf(strSeperatorArray(2) = "NULL", "null", "'" + strSeperatorArray(2) + "'").ToString() + "," + IIf(strSeperatorArray(3) = "NULL", " null ", "'" + strSeperatorArray(3) + "' ").ToString()
                                strSQL = "EXEC usp_Ins_tbl_CRM_Function_RequestTypes_Mapping " + strFunctionID + "," + strSeperatorArray(0) + "," + strSeperatorArray(1) + "," + IIf(strSeperatorArray(2) = "NULL", "null", "'" + strSeperatorArray(2) + "'").ToString() + "," + IIf(strSeperatorArray(3) = "NULL", " null ", "'" + strSeperatorArray(3) + "' ").ToString() + "," + strSeperatorArray(1)
                            Else
                                strSQL = "EXEC usp_Ins_tbl_CRM_Function_RequestTypes_Mapping " + strFunctionID + "," + strSeperatorArray(0) + "," + strSeperatorArray(1) + "," + IIf(strSeperatorArray(2) = "NULL", "null", "'" + strSeperatorArray(2) + "'").ToString() + "," + IIf(strSeperatorArray(3) = "NULL", " null ", "'" + strSeperatorArray(3) + "' ").ToString() + ",NULL"
                            End If
                        Else
                            strSQL = "EXEC usp_Ins_tbl_CRM_Function_RequestTypes_Mapping " + strFunctionID + "," + strSeperatorArray(0) + "," + strSeperatorArray(1) + "," + IIf(strSeperatorArray(2) = "NULL", "null", "'" + strSeperatorArray(2) + "'").ToString() + "," + IIf(strSeperatorArray(3) = "NULL", " null ", "'" + strSeperatorArray(3) + "' ").ToString() + ",NULL"
                        End If
                        'End of modification by ShraddhaM on 9,Sept 2008

                        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

                    Next

                End If
            End If

        End If
        'end of addition done by SuchitraP on 30-MAY-2007 for HelpDesk

        MyBase.strListPage = "CRM_ConfigureRequestType_CommonList.aspx"
        MyBase.strFormPage = "CRM_ConfigureRequestType_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub
#End Region


    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        'Addition done by SuchitraP on 30-May-2007 for HelpDesk
        Dim strScript As New System.Text.StringBuilder
        strScript.Append("<Script language=javascript>" + vbCrLf)
        strScript.Append("function DepartmentIDOnChange() {" + vbCrLf)

        strScript.Append("objfrm.action=""../CRM/CRM_ConfigureRequestType_CommonList.aspx?"";" + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("}")

        strScript.Append("function RequestTypeIDOnChange() {" + vbCrLf)
        strScript.Append("objfrm.action=""../CRM/CRM_ConfigureRequestType_CommonList.aspx?"";" + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("}" + vbCrLf)
        '        strScript.Append("</Script>" + vbCrLf)

        'Addition done by SuchitraP on 4-Jul-2007
        'Persisting value of Request type combo
        strScript.Append("function SubRequestType_onClick(FunctionReqType,strPKToken) {" + vbCrLf)
        strScript.Append("objfrm.action='../CRM/CRM_ConfigureRequestType_CommonPage.aspx?FunctionRequestTypeID_PK='+FunctionReqType+'&PKToken='+strPKToken+'&ReqTypeID='+GetObjectReference('frmCommonPage','cboRequestTypeID').value+'&MasterTagID=3746&FromWhere=&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';" + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("}" + vbCrLf)
        strScript.Append("</Script>" + vbCrLf)
        'End of addition done by SuchitraP on 4-Jul-2007

        HttpContext.Current.Response.Write(strScript.ToString)


        'End of Addition done by SuchitraP on 30-May-2007 for HelpDesk
    End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CRM_ConfigureRequestType_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New CRM_ConfigureRequestType_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        'Addition done by SuchitraP on 29-MAY-2007 for HelpDesk
        Dim strReqID As String
        If Not Request.QueryString("FunctionID") Is Nothing Then
            m_strDepartmentID = Request.QueryString("FunctionID")
        Else
            If Not Request.Form("cboDepartmentID") Is Nothing Then
                m_strDepartmentID = Request.Form("cboDepartmentID")
            End If
        End If


        If Request.Form("cboRequestTypeID") Is Nothing Then
            m_strRequestTypeID = ""
        Else
            m_strRequestTypeID = Request.Form("cboRequestTypeID")

        End If

        Dim strSQL As String = ""
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "SELECT DepartmentID,Department FROM tbl_PM_DepartmentMaster ORDER BY Department"
        strSQL = "usp_sel_tbl_PM_DepartmentMaster_DepartmentID"
        ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("Department")
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboDepartmentID", strSQL, 200, m_strDepartmentID, "onChange='DepartmentIDOnChange()'", False)
        CommonFunction.General.WriteHTML("</TD>")
        'CommonFunction.General.WriteHTML("</TR><br>")
        'CommonFunction.General.WriteHTML("</TABLE>")
        'End of addition done by SuchitraP on 29-MAY-2007 for HelpDesk

        'Addition done by SuchitraP on 4-Jul-2007 
        'Persisting value of Request type combo
        If m_strRequestTypeID = "" Then
            If Not HttpContext.Current.Request.Form("hidReqTypeID") Is Nothing Then
                m_strRequestTypeID = HttpContext.Current.Request.Form("hidReqTypeID")
            End If
        End If
        'End of Addition done by SuchitraP on 4-Jul-2007 

        'Addition done by SuchitraP on 30-MAY-2007
        Dim strString As String = ""
        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strString = "SELECT A.RequestTypeID,RequestType FROM tbl_CRM_RequestType A INNER JOIN (SELECT DISTINCT RequestTypeID FROM tbl_CRM_RequestType_SubRequestType ) B ON A.RequestTypeID = B.RequestTypeID ORDER BY RequestType "
        strString = "usp_Sel_tbl_CRM_RequestType_RequestTypeID "
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        'CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("Request Type")
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboRequestTypeID", strString, 200, m_strRequestTypeID, "onChange='RequestTypeIDOnChange()'", True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR><br>")
        CommonFunction.General.WriteHTML("</TABLE>")
        'End of addition by SuchitraP on 30-MAY-2007
    End Sub
End Class
Public Class CRM_ConfigureRequestType_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added by SuchitraP on 29-MAY-2007 for HelpDesk
        If Args.ColumnName.ToUpper = "DELETE" Then
            Args.ColumnName = "Select"
        End If
        ''End of addition by SuchitraP on 29-MAY-2007 for HelpDesk
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Addition done by SuchitraP on 29-MAY-2007 for HelpDesk

        'Addition done by SuchitraP on 4-Jul-2007
        'Persisting value of Request type combo
        Dim ischkChecked As Boolean
        Dim strPKToken As String = ""
        Dim strFunctionRequestID As String = ""
        'End of addition done by SuchitraP on 4-Jul-2007

        If Args.ColumnName.ToUpper = "SUBREQUEST TYPE" Then
            If CType(Args.DataReader("IsMapp").ToString, Double) = 0 Then
                Cancel = True
                Args.StringToBeInserted = "<td>" + Args.DataReader("SubRequestType").ToString + "</td>"
            End If
        End If

        If Args.ColumnName.ToUpper = "DELETE" Then
            If Args.DataReader("IsMapp").ToString = "1" Then
                If Args.DataReader("IsUsed").ToString = "1" Then
                    Cancel = True
                    'Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked disabled name='chkDelete' id='chkDelete' class='clsCheckBox' value=" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "></TD>"
                    Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked disabled name='chkDelete' id='chkDelete' class='clsCheckBox' value='" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "|" + CommonFunction.General.CheckIsNothing(Args.DataReader("GroupName"), "NULL").Replace("'", "&#39;").Replace(",", "$~") + "|" + CommonFunction.General.CheckIsNothing(Args.DataReader("GroupEmail"), "NULL").Replace("'", "&#39;").Replace(",", "$~") + "|" + CType(Args.DataReader("REPORTINGTOAPPROVAL"), String) + "' ></TD>"
                    ischkChecked = True
                ElseIf Args.DataReader("IsUsed").ToString = "0" Then
                    Cancel = True
                    'Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value=" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "></TD>"
                    Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value='" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "|" + CommonFunction.General.CheckIsNothing(Args.DataReader("GroupName"), "NULL").Replace("'", "&#39;").Replace(",", "$~") + "|" + CommonFunction.General.CheckIsNothing(Args.DataReader("GroupEmail"), "NULL").Replace("'", "&#39;").Replace(",", "$~") + "|" + CType(Args.DataReader("REPORTINGTOAPPROVAL"), String) + "' ></TD>"
                    ischkChecked = True
                End If
            Else
                Cancel = True
                'Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' name='chkDelete' id='chkDelete' class='clsCheckBox' value=" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "></TD>"
                Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' name='chkDelete' id='chkDelete' class='clsCheckBox' value='" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "|" + CommonFunction.General.CheckIsNothing(Args.DataReader("GroupName"), "NULL").Replace("'", "&#39;").Replace(",", "$~") + "|" + CommonFunction.General.CheckIsNothing(Args.DataReader("GroupEmail"), "NULL").Replace("'", "&#39;").Replace(",", "$~") + "|" + CType(Args.DataReader("REPORTINGTOAPPROVAL"), String) + "' ></TD>"
            End If
        End If

        'Addition done by SuchitraP on 4-Jul-2007
        'Persisting value of Request type combo

        'To generate token
        strFunctionRequestID = Args.DataReader("FunctionRequestTypeID").ToString
        strPKToken = CommonFunctions.Security.Token.GetToken(CType(strFunctionRequestID, String) + HttpContext.Current.Session("intUserID").ToString + "0" + "3746")

        If Args.ColumnName.ToUpper = "SUBREQUEST TYPE" Then
            If Args.DataReader("IsMapp").ToString = "1" Then
                If Args.DataReader("IsUsed").ToString = "1" Then
                    ischkChecked = True
                ElseIf Args.DataReader("IsUsed").ToString = "0" Then
                    ischkChecked = True
                End If
            End If
            If ischkChecked = True Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=Left ><A href="
                Args.StringToBeInserted &= "JavaScript:SubRequestType_onClick('" + Args.DataReader("FunctionRequestTypeID").ToString + "','" + strPKToken + "')>"
                Args.StringToBeInserted &= Args.DataReader("SubRequestType").ToString + "</A></TD>"

            End If
        End If
        'End of addition done by SuchitraP on 4-Jul-2007

        'End of addition done by SuchitraP on 29-MAY-2007 for HelpDesk
        'Added by ShraddhaM on 29,Aug 2008
        'ReporingTo Approval against subRequestType
        If Args.DataField.ToUpper() = "REPORTINGTOAPPROVAL" Then
            Cancel = True

            'If Args.DataReader("REPORTINGTOAPPROVAL") = "1" Then
            '    Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked name='chkApproval" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "' id='chkApproval" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "' class='clsCheckBox' value='" + CType(Args.DataReader("REPORTINGTOAPPROVAL"), String) + "' ></TD>"
            'Else
            '    Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' name='chkApproval" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "' id='chkApproval" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "' class='clsCheckBox' value='" + CType(Args.DataReader("REPORTINGTOAPPROVAL"), String) + "' ></TD>"
            'End If

            If Args.DataReader("REPORTINGTOAPPROVAL") = "1" Then
                If Args.DataReader("IsMapp").ToString = "1" And Args.DataReader("IsUsed").ToString = "1" Then
                    Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' disabled checked name='chkApproval" + Args.DataReader("RequestTypeID").ToString + "' id='chkApproval" + Args.DataReader("RequestTypeID").ToString + "' class='clsCheckBox' value='" + Args.DataReader("SubRequestTypeID").ToString + "' ></TD>"
                Else
                    Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked name='chkApproval" + Args.DataReader("RequestTypeID").ToString + "' id='chkApproval" + Args.DataReader("RequestTypeID").ToString + "' class='clsCheckBox' value='" + Args.DataReader("SubRequestTypeID").ToString + "' ></TD>"
                End If
            Else
                'If Args.DataReader("IsMapp").ToString = "1" And Args.DataReader("IsUsed").ToString = "1" Then
                '    Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' disabled name='chkApproval" + Args.DataReader("RequestTypeID").ToString + "' id='chkApproval" + Args.DataReader("RequestTypeID").ToString + "' class='clsCheckBox' value='" + Args.DataReader("SubRequestTypeID").ToString + "' ></TD>"
                'Else
                Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' name='chkApproval" + Args.DataReader("RequestTypeID").ToString + "' id='chkApproval" + Args.DataReader("RequestTypeID").ToString + "' class='clsCheckBox' value='" + Args.DataReader("SubRequestTypeID").ToString + "' ></TD>"
                'End If

            End If

        End If
        'End of addition by ShraddhaM
    End Sub
End Class

Class CRM_ConfigureRequestType_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        'Addition done by SuchitraP on 29-MAY-2007 for HelpDesk
        Dim strDepartmentID As String
        Dim strRequestTypeID As String

        If Not HttpContext.Current.Request.QueryString("FunctionID") Is Nothing Then
            strDepartmentID = HttpContext.Current.Request.QueryString("FunctionID")
        Else
            If Not HttpContext.Current.Request.Form("cboDepartmentID") Is Nothing Then
                strDepartmentID = HttpContext.Current.Request.Form("cboDepartmentID")
            End If
        End If

        If Not HttpContext.Current.Request.Form("cboRequestTypeID") Is Nothing Then
            strRequestTypeID = HttpContext.Current.Request.Form("cboRequestTypeID")
            'ElseIf Not HttpContext.Current.Request.Form("cboRequestTypeID") = "" Then
            '    strRequestTypeID = HttpContext.Current.Request.Form("cboRequestTypeID")
        End If

        'Addition done by SuchitraP on 4-Jul-2007
        'Persisting value of Request type combo
        If strRequestTypeID = "" Then
            If Not HttpContext.Current.Request.Form("hidReqTypeID") Is Nothing Then
                strRequestTypeID = HttpContext.Current.Request.Form("hidReqTypeID")
            End If
        End If
        'End of Addition done by SuchitraP on 4-Jul-2007

        If strDepartmentID = "" Then
            GetPageSpecificFilters += "AND ( 1 =  2 )"
        Else
            GetPageSpecificFilters += " AND (FunctionID= " + strDepartmentID + " )"
        End If

        If strRequestTypeID <> "" Then
            GetPageSpecificFilters += " AND (RequestTypeID= " + strRequestTypeID + " )"
        End If

        'End of addition done by SuchitraP on 29-MAY-2007 for HelpDesk



    End Function
End Class
