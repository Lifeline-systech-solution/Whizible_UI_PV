Imports CommonEngines.General.cEventHandlers
Public Class Work_Product_Type_CommonList
    Inherits CommonList
    Protected strcurrtestsessionid As String


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
        MyBase.strListPage = "Work_Product_Type_CommonList.aspx"
        MyBase.strFormPage = "Work_Product_Type_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cWork_Product_Type_CommonList(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        ' Modified By MahendraV On 4:18 PM 6/29/2007 For WhizibleSEM 7
        ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes
        ' Commented code moved from PageListPreRender To WhizForm_Init
        ' Start_MV_6/29/2007
        ' Dim strSQL As String
        'Dim workprod_type As String
        'Dim workprod_id As Integer
        Dim strselectedworkprod As String
        ' Dim drworkprod As IDataReader
        Dim strscript As String
        'Dim strid As String
        'Dim arrComma As Char() = {","c}
        strcurrtestsessionid = CStr(HttpContext.Current.Request.QueryString("TestSessionID"))

        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strcurrtestsessionid = Request.Form("txthidCurrentworkproductID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkproductID", "txthidCurrentworkproductID", , , , strcurrtestsessionid, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            strcurrtestsessionid = CType(HttpContext.Current.Request.QueryString("TestSessionID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkproductID", "txthidCurrentworkproductID", , , , strcurrtestsessionid, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        If strcurrtestsessionid = "" Then
            strcurrtestsessionid = CType(HttpContext.Current.Request.Form("txtTestSessionID"), String) + ""
        End If

        If CStr(HttpContext.Current.Request.QueryString("Save")) = "True" Then

            ' strselectedworkprod = CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Request.Form("chkDelete"), String))
            strselectedworkprod = CType(HttpContext.Current.Request.Form("chkDelete"), String)
            If strselectedworkprod <> "" Then
                'Dim strlist As String() = strselectedworkprod.Split(arrComma)
                'For Each strid In strlist
                '    strSQL = "usp_TCM_ins_WorkProdSchedule " + strid + ", " + strcurrtestsessionid.ToString
                '    drworkprod = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                'Next
                strscript = vbCrLf + "<Script language=javascript>"
                strscript += vbCrLf + "    refreshParent('frmCommonPage','Test_Session_CommonPage.aspx?','Test_Session_CommonPage.aspx?FromWhere=PM&MasterTagID=3654&SubTagID=10051&TestSessionID=" + strcurrtestsessionid.ToString + "');"
                strscript += vbCrLf + "    window.close();"
                strscript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strscript)
            End If
            
        End If
        ' End_MV_6/29/2007
    End Function



    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SAVEPRODUCT_ONCLICK" Then
            'If strcurrtestsessionid <> "" Then
            '    Args.ToBeInsertedInFunction = "var objForm,intItems,intCtr,blnSelected,strCheckboxIDs;" + vbCrLf
            '    Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            '    Args.ToBeInsertedInFunction += "objForm.action='../TCM/Work_Product_Type_CommonList.aspx?FromWhere=PM&MasterTagID=3678&TestSessionID=" + strcurrtestsessionid.ToString + "&Save=True'" + vbCrLf
            '    Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            '    Args.ToBeInsertedInFunction += "return;" + vbCrLf
            'Else
            Args.ToBeInsertedInFunction = "var objForm,intItems,intCtr,blnSelected,strCheckboxIDs;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            'modified by SonalD on 27th Feb 2009
            'Args.ToBeInsertedInFunction += "objForm.action='../TCM/Work_Product_Type_CommonList.aspx?FromWhere=PM&MasterTagID=3678&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../TCM/Work_Product_Type_CommonList.aspx?FromWhere=PM&MasterTagID=3678&Save=True&TestSessionID=" + strcurrtestsessionid.ToString + "'" + vbCrLf
            'End of modification by SonalD on 27th Feb 2009
            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf
            'End If

        End If
    End Sub


    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        Dim strSQL As String
        'Dim workprod_type As String
        'Dim workprod_id As Integer
        Dim strselectedworkprod As String
        Dim drworkprod As IDataReader
        'Dim strscript As String
        Dim strid As String
        Dim arrComma As Char() = {","c}
        strcurrtestsessionid = CStr(HttpContext.Current.Request.QueryString("TestSessionID"))

        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strcurrtestsessionid = Request.Form("txthidCurrentworkproductID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkproductID", "txthidCurrentworkproductID", , , , strcurrtestsessionid, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            strcurrtestsessionid = CType(HttpContext.Current.Request.QueryString("TestSessionID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkproductID", "txthidCurrentworkproductID", , , , strcurrtestsessionid, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        If strcurrtestsessionid = "" Then
            strcurrtestsessionid = CType(HttpContext.Current.Request.Form("txtTestSessionID"), String) + ""
        End If

        If CStr(HttpContext.Current.Request.QueryString("Save")) = "True" Then

            ' strselectedworkprod = CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Request.Form("chkDelete"), String))
            strselectedworkprod = CType(HttpContext.Current.Request.Form("chkDelete"), String)
            If strselectedworkprod <> "" Then
                Dim strlist As String() = strselectedworkprod.Split(arrComma)
                For Each strid In strlist
                    strSQL = "usp_TCM_ins_WorkProdSchedule '" + strid + "', " + strcurrtestsessionid.ToString
                    'drworkprod = 
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                Next
            End If
            'Added by SonalD on 27th Feb 2009
            If strselectedworkprod Is Nothing Then
                CommonFunction.General.WriteHTML("<Script language=javascript>")
                CommonFunction.General.WriteHTML("alert('Please select at least one work product')")
                CommonFunction.General.WriteHTML("</Script>")
            End If
            'End of addition by sonalD on 27th Feb 2009
        End If

    End Sub
End Class


Public Class cWork_Product_Type_CommonList
    Inherits CommonEngine.CommonList.cPlotGrid
    Protected m_sbValidationScript As String
    Dim m_strprevsection As String
    'Dim m_strprevsectionID As String
    Dim m_intCount As Integer
    Dim m_strsectionheader As String
    Dim m_CheckboxIDs As String
    Dim m_strTestCaseIDs As String
    Dim strstrTestCaseIdBox As String
    'Added by SonalD on 27th Feb 2009
    Dim strTestSessionID As String
    Dim strWorkProductID As String
    'End of addition by SonalD on 27th Feb 2009



    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

        'Common Page is accessed from CommonList
        Dim strWhere As String
        '###
        ' Dim strTestSessionID As String
        strTestSessionID = HttpContext.Current.Request.QueryString("TestSessionID") + ""


        If strTestSessionID = "" Then
            strTestSessionID = HttpContext.Current.Request.Form("txtTestSessionID") + ""
        End If

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtTestSessionID", "txtTestSessionID", , , , strTestSessionID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strTestSessionID = HttpContext.Current.Request.Form("txthidCurrentworkprodID").ToString

            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkprodID", "txthidCurrentworkprodID", , , , strTestSessionID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            strTestSessionID = CType(HttpContext.Current.Request.QueryString("TestSessionID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkprodID", "txthidCurrentworkprodID", , , , strTestSessionID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        If strTestSessionID <> "" Then
            strWhere = " AND WorkProductId Not in (Select WorkProductId from tbl_TCM_TestSessionWorkProducts "
            strWhere += " Where TestSessionId = " + strTestSessionID + ")"
        Else
            strWhere = " AND WorkProductId Not in (Select WorkProductId from tbl_TCM_TestSessionWorkProducts )"
        End If
        Args.GridSQL = Replace(Args.GridSQL, "ORDER", strWhere + " ORDER ")

    End Sub
    'Added by SonalD on 27th Feb 2009,For issue ID 27938
    'Purpose: For he worproducts that are already selected,checkbox should be selected when one opens that page
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.Before_GridDataRowTD_Print(Cancel, Args, WhizGlobal)
        Dim Str As String
        Dim bln As Boolean
        If Args.ColumnName.ToUpper = "SELECT" Then
            '###
            'strTestSessionID = HttpContext.Current.Request.QueryString("TestSessionID")
            strWorkProductID = Args.DataReader("WorkProductId").ToString
            Str = "usp_sel_tbl_TCM_TestSessionWorkProducts " + strTestSessionID + ",'" + strWorkProductID + "'"
            bln = CommonFunction.Data.GetDataScalar(Str, True)
            Cancel = True
            Args.StringToBeInserted = "<TD align=center> " + CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , bln, Args.DataReader("WorkProductId").ToString, , , True) + "</TD>"
        End If
    End Sub
    'End of addition by SonalD on 27th Feb 2009
End Class