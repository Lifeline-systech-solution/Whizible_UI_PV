Imports CommonEngines.General.cEventHandlers
Public Class ModuleAccess_CommonList
    Inherits CommonList

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
        MyBase.strListPage = "ModuleAccess_CommonList.aspx"
        MyBase.strFormPage = "ModuleAccess_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
        MyBase.ApplySecurity(True)
    End Sub


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New ModuleAccess_cPlotGrid(MyBase.m_objGlobal)

    End Function

End Class

Public Class ModuleAccess_cPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private strXMLPath As String = HttpContext.Current.Server.MapPath("../GENERAL/").ToString + "WhizModules.xml"
    Protected strModule() As String = {}
    Protected strLicences() As String = {}

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
        InitArray()
    End Sub

    Private Sub InitArray()
        Dim dXMLSet As New DataSet()
        Dim dXMLRdr As DataTableReader
        Dim m_validXML As String = ""
        Dim i As Integer = 0
        Try
            m_validXML = MLCommonFunction.ML_CommonFunction.Validate_Modulexml(strXMLPath)
            If m_validXML = "" Then
                If CommonFunctions.FileDirectory.IsFileExists(strXMLPath) Then
                    dXMLSet.ReadXml(strXMLPath)
                    dXMLRdr = dXMLSet.CreateDataReader()
                    While dXMLRdr.Read()
                        ReDim Preserve strModule(UBound(strModule) + 1)
                        ReDim Preserve strLicences(UBound(strLicences) + 1)
                        strLicences(i) = MLCommonFunction.ML_CommonFunction.Decrypt(dXMLRdr("Licences_Text").ToString())
                        strModule(i) = strLicences(i).Substring(strLicences(i).IndexOf("/") + 1, strLicences(i).LastIndexOf("/") - (strLicences(i).IndexOf("/") + 1))
                        strLicences(i) = strLicences(i).Substring(strLicences(i).LastIndexOf("/") + 1)
                        If strLicences(i) = "" Then
                            strLicences(i) = 0
                        End If
                        i = i + 1
                    End While
                End If
            Else
                HttpContext.Current.Response.Write("<DIV ID='PageDiv' Style='Height:400px;WIDTH:100%;OVERFLOW:auto;'>")
                HttpContext.Current.Response.Write("<TABLE class=clsTABLE Width='100%' Height='100%'>")
                HttpContext.Current.Response.Write("<TR><TD align=Center class=clsTDGroupFooter><B>" + m_validXML + "</B></TD></TR>")
                HttpContext.Current.Response.Write("</TABLE></DIV>")
            End If
        Catch ex As Exception
            HttpContext.Current.Response.Write(ex.Message)
        Finally
        End Try
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "AVAILABLELICENCES" Then
            Cancel = True
            Args.StringToBeInserted += "<td align=Right><Font Size=2>"
            Dim i As Integer = 0
            ' Args.IgnoreActualValue = True
            For i = 0 To strModule.Length - 1
                If Args.DataReader("ModuleTagId") = strModule(i) Then
                    Args.StringToBeInserted += strLicences(i)
                End If
            Next
            Args.StringToBeInserted += "</Font></td>"
            'Dim i As Integer = 0
            'Args.IgnoreActualValue = True
            'For i = 0 To strModule.Length - 1
            '    If Args.DataReader("ModuleTagId") = strModule(i) Then
            '        Args.ReplacementValue = strLicences(i)
            '    End If
            'Next


        End If
        If Args.DataField.ToUpper = "ISSUEDLICENCES" Then
            Cancel = True
            Args.StringToBeInserted += "<td align=Right><Font Size=2>"
            Args.StringToBeInserted += Args.DataReader("IssuedLicences").ToString
            Args.StringToBeInserted += "</Font></td>"
        End If
        If Args.DataField.ToUpper = "REMAININGLICENCES" Then
            Cancel = True
            Args.StringToBeInserted += "<td align=Right><Font Size=2>"
            'Args.IgnoreActualValue = True
            Dim i As Integer = 0
            Dim intRemLiv As Integer
            For i = 0 To strModule.Length - 1
                If Args.DataReader("ModuleTagId") = strModule(i) Then
                    Args.StringToBeInserted += CType(CType(strLicences(i), Integer) - CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssuedLicences"), 0), Integer), String)
                    'Args.ReplacementValue = strLicences(i) - CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssuedLicences"), 0)
                End If
            Next
            Args.StringToBeInserted += "</Font></td>"
        End If
    End Sub
End Class
