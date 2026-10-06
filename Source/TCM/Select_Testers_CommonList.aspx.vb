Imports CommonEngines.General.cEventHandlers
Public Class Select_Testers_CommonList
    Inherits CommonList

    Dim strConductedBy As String


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
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "Select_Testers_CommonList.aspx"
        MyBase.strFormPage = "Select_Testers_CommonPage.aspx"
        'MyBase.strSubTagPage = "../General/CommonSubTag.aspx" 
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strSelectedTesters As String
        Dim strSQL As String
        Dim strCondBy As String
        Dim drSelectedTesters As String
        Dim strid As String
        Dim dreader As IDataReader
        Dim strEmployeeName As String
        Dim StrNDBValue As String
        Dim strScript As String



        'Code Added By PradipK
        If CommonFunction.General.CheckIsNothing(Request.QueryString("ConductedBy"), "0") <> "0" Then
            strConductedBy = CType(HttpContext.Current.Request.QueryString("ConductedBy"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidConductedBy", "txthidConductedBy", , , , strConductedBy, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            strConductedBy = Request.Form("txthidConductedBy").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidConductedBy", "txthidConductedBy", , , , strConductedBy, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If


        'End Addition By PradipK




        If HttpContext.Current.Request.QueryString("Select") = "True" Then
            ''Code added by ChristinaT
            'strSelectedTesters = CType(HttpContext.Current.Request.Form("chkDelete"), String)


            'strSelectedTesters = CType(HttpContext.Current.Request.Form("chkDelete"), String)
            'If strConductedBy <> "" And strSelectedTesters <> "" Then
            '    strSelectedTesters = strConductedBy + ","
            '    strSelectedTesters += CType(HttpContext.Current.Request.Form("chkDelete"), String)
            'Else
            '    strSelectedTesters = CType(HttpContext.Current.Request.Form("chkDelete"), String)
            'End If
            ''End of Addition By ChristinaT
            strSelectedTesters = CType(HttpContext.Current.Request.Form("chkDelete"), String)
            strSQL = "usp_TCM_Sel_Testers '" + strSelectedTesters + "'"
            drSelectedTesters = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0")
            If strSelectedTesters <> "" Then
                CommonFunction.General.WriteHTML("<Script language=javascript >")

                CommonFunction.General.WriteHTML("var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase1');")

                CommonFunction.General.WriteHTML("objNDB1.value="""";")
                'CommonFunction.General.WriteHTML("objNDB1.value=""" + strSelectedTesters.Trim + """;")
                'Modified By NitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 
                'If Employee Name has single Quote javascript error is generated
                CommonFunction.General.WriteHTML("objNDB1.value=""" + Replace(drSelectedTesters.Trim, """", "\""") + """;")
                ' End Modification  By NitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 

                CommonFunction.General.WriteHTML("var objConductedBy = GetParentObjectReference('frmCommonPage','ConductedBy');")
                CommonFunction.General.WriteHTML("objConductedBy.value="""";")
                'CommonFunction.General.WriteHTML("objConductedBy.value=""" + drSelectedTesters.Trim + """;")
                CommonFunction.General.WriteHTML("objConductedBy.value=""" + strSelectedTesters.Trim + """;")
                CommonFunction.General.WriteHTML("window.close();")
                CommonFunction.General.WriteHTML("</Script>")


                'Else
                'CommonFunction.General.WriteHTML("<Script language=javascript >")
                'CommonFunction.General.WriteHTML("var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase1');")
                'CommonFunction.General.WriteHTML("if(objNDB1.value!=''){")
                'CommonFunction.General.WriteHTML("var ArrID = objNDB1.value;")
                'CommonFunction.General.WriteHTML("var StrArrID =ArrID.split("""");")
                'CommonFunction.General.WriteHTML("alert(StrArrID);")
                'CommonFunction.General.WriteHTML("var objChkSel = GetObjectReference('Select_Testers_CommonList.aspx','ChkDelete',true);")
                'CommonFunction.General.WriteHTML("var objArr=objChkSel.value;")

                'CommonFunction.General.WriteHTML("var Strobj =objArr.split("""");")
                'CommonFunction.General.WriteHTML("alert(objArr);")
                'CommonFunction.General.WriteHTML("for(i = 0; i <= Strobj.length-1; i++){for(j=0;j<=StrArrID.length-1;j++){ if( Strobj[i]==StrArrID[i]){Strobj[j].checked=true; break;}}}")
                'CommonFunction.General.WriteHTML("}")
                'CommonFunction.General.WriteHTML("</Script>")

            Else
                strScript = vbCrLf + "<Script language=javascript>"
                strScript += vbCrLf + "    alert('Please Select atleast 1 resource');"
                'strScript += vbCrLf + "    return;"
                strScript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strScript)

            End If

        End If


    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    End Function


    Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ClientSideFunctionName.ToUpper = "SELECT_ONCLICK" Then
            Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../TCM/Select_Testers_CommonList.aspx?FromWhere=PM&MasterTagId=3661&Select=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf

        End If


    End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Sub RegisterClientScriptBlock(ByVal key As String, ByVal script As String)

    'End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cSelectTestersPlotGrid(MyBase.m_objGlobal)
    End Function

    Private Sub Page_Init1(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Init

    End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    '  Args.SQL = ""
    '    Dim strSQL As String = Args.SQL
    '    Dim strConductedby As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ConductedBy"), "")
    '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ConductedBy"), "0") <> "0" Then
    '        strConductedby = CType(HttpContext.Current.Request.QueryString("ConductedBy"), String)
    '    Else
    '        strConductedby = CStr(HttpContext.Current.Request.Form("txthidConductedBy"))
    '    End If
    '    If strConductedby <> "" Then
    '        strSQL = strSQL.Replace("ORDER BY", "  UNION SELECT tbl_PM_ProjectEmployeeRole.EmployeeID,tbl_PM_Employee.EmployeeName,tbl_PM_ProjectEmployeeRole.ExpectedStartDate,tbl_PM_ProjectEmployeeRole.ExpectedEndDate,	tbl_PM_ProjectEmployeeRole.ActualStartDate,tbl_PM_Role.RoleDesCription, tbl_PM_ProjectEmployeeRole.ActualEndDate, tbl_PM_ProjectEmployeeRole.ProjectEmployeeRoleId,tbl_PM_ProjectEmployeeRole.ProjectId  From  tbl_PM_ProjectEmployeeRole left outer join tbl_PM_Employee on tbl_PM_ProjectEmployeeRole.EmployeeID=tbl_PM_Employee.EmployeeID left outer join tbl_PM_Role on tbl_PM_ProjectEmployeeRole.Role=tbl_PM_Role.RoleID Where IsNULL(ActualEndDate,0) <> 0  AND ProjectID=" + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID")), String) + " AND tbl_PM_ProjectEmployeeRole.EmployeeID IN (" + strConductedby + ") ORDER BY")
    '        Args.SQL = strSQL
    '    End If
    '    'End Addition By PradipK
    'End Sub

    'End Sub
End Class
Public Class cSelectTestersPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
    End Sub



    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        'Dim strEmpID As String
        'Dim blnChecked As Boolean

        'blnChecked = False

        'If Args.CheckBoxId <> "" Then
        '    'if EmployeeID present in the list then check the checkbox
        '    strEmpID = Args.DataReader("EmployeeID").ToString + ""
        '    'Added By SatyanarayanaA on 19-Jan-2005 

        '    If m_strRevieweeIDList.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
        '        blnChecked = True
        '    End If

        'End If
        ''Ended By SatyanarayanaA on 19-Jan-2005 

        'Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , blnChecked, strEmpID.Trim, , " onclick=javascript:chkSelect_OnClick(this)", True) + "</td>"
        'Cancel = True
        'End If
        Dim strConductedby As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ConductedBy"), "")
        'Code Added By PradipK
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ConductedBy"), "0") <> "0" Then
            strConductedby = CType(HttpContext.Current.Request.QueryString("ConductedBy"), String)
        Else
            strConductedby = CStr(HttpContext.Current.Request.Form("txthidConductedBy"))
        End If
        'End Addition By PradipK

        Dim intcount As Integer
        '        Dim strTestsessionid As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TestSessionID"), "")
        If strConductedby <> "" Then
            'Dim strSQL As String = "Select ConductedBy from tbl_TCM_TestSession where TestSessionID=" + strTestsessionid.ToString
            'Dim strSelectedID() As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "").Split(","c)
            Dim strSelectedID() As String = strConductedby.Split(","c)

            For intcount = 0 To strSelectedID.Length - 1
                If strSelectedID(intcount) = Args.DataReader(0).ToString Then
                    Args.IsSelected = True
                End If
            Next
        End If
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Code Added By PradipK
        Dim strSQL As String = Args.GridSQL
        Dim strConductedby As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ConductedBy"), "")
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ConductedBy"), "0") <> "0" Then
            strConductedby = CType(HttpContext.Current.Request.QueryString("ConductedBy"), String)
        Else
            strConductedby = CStr(HttpContext.Current.Request.Form("txthidConductedBy"))
        End If
        If strConductedby <> "" Then
            strSQL = strSQL.Replace("ORDER BY", "  UNION SELECT tbl_PM_ProjectEmployeeRole.EmployeeID,tbl_PM_Employee.EmployeeName,tbl_PM_ProjectEmployeeRole.ExpectedStartDate,tbl_PM_ProjectEmployeeRole.ExpectedEndDate,	tbl_PM_ProjectEmployeeRole.ActualStartDate,tbl_PM_Role.RoleDesCription, tbl_PM_ProjectEmployeeRole.ActualEndDate, tbl_PM_ProjectEmployeeRole.ProjectEmployeeRoleId,tbl_PM_ProjectEmployeeRole.ProjectId  From  tbl_PM_ProjectEmployeeRole left outer join tbl_PM_Employee on tbl_PM_ProjectEmployeeRole.EmployeeID=tbl_PM_Employee.EmployeeID left outer join tbl_PM_Role on tbl_PM_ProjectEmployeeRole.Role=tbl_PM_Role.RoleID Where IsNULL(ActualEndDate,0) <> 0  AND ProjectID=" + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID")), String) + " AND tbl_PM_ProjectEmployeeRole.EmployeeID IN (" + strConductedby + ") ORDER BY")
            Args.GridSQL = strSQL
        End If
        'End Addition By PradipK
    End Sub

End Class


