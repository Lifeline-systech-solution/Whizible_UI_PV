Option Strict Off
Imports ProjectByNet
Public Class PRD_CommonFunctions
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

    Dim strPkFieldValue, strProjectID, strCustomerControlValue As String

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        '' Added By ParagD On 24-May-2006
        '' Purpose : RoamWare Customization

        If Not IsNothing(HttpContext.Current.Request.QueryString("ProjectID")) Then
            If Not CType(HttpContext.Current.Request.QueryString("ProjectID"), String) = "" Then
                strProjectID = CType(HttpContext.Current.Request.QueryString("ProjectID"), String)
            Else
                strProjectID = CType(HttpContext.Current.Session("intProjectID"), String)
            End If
        End If

        strPkFieldValue = Request.QueryString.Get("MasterPKValue").ToString

        strCustomerControlValue = Request.QueryString.Get("CustomerComboValue").ToString

        Dim strdpendentControlName As String
        strdpendentControlName = Request.QueryString.Get("DependentControlName").ToString

        Dim strCheckCustomerFlag, strDeliverableLevelCustomer As String
        If Session("LoginType") = "C" Then
            strDeliverableLevelCustomer = "True"
        Else
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''strCheckCustomerFlag = "SELECT ISNULL(DeliverableLevelCustomer ,0) FROM tbl_PM_Project WHERE ProjectID = " & strProjectID
            strCheckCustomerFlag = "usp_sel_tbl_PM_Project_DeliverableLevelCustomer " & strProjectID

            strDeliverableLevelCustomer = CommonFunctions.Data.GetDataScalar(strCheckCustomerFlag, True)
        End If


        If strDeliverableLevelCustomer = "True" Then
            If strdpendentControlName = "ProductVersionID" Or strdpendentControlName = "CRProductVersionID" Then
                Call Display_CustomerLevel_ProductVersions()
            Else
                Call Display_CustomerLevel_ProductVersionComponents()
            End If
        Else
            Call Display_ProjectLevel_ProductVersionsComponents()
        End If
        '' END : Added By ParagD On 24-May-2006
    End Sub

    '' Select Customer Level Product Versions
    Public Function Display_CustomerLevel_ProductVersions()


        Dim strSQLQuery, strDependentControlName, strCboValue, strProduct, strProductVersionID, strProductVersion, strAllProductVersion As String
        Dim drProductVersions As IDataReader

        'strProjectID = CType(HttpContext.Current.Session("intProjectID"), String)

        If Not Request.QueryString.Get("DependentControlName") Is Nothing Then
            strDependentControlName = Request.QueryString.Get("DependentControlName").ToString
            If Not strDependentControlName = "" Then
                If Not Request.QueryString.Get("CboValue") Is Nothing Then
                    strCboValue = Request.QueryString.Get("CboValue").ToString
                End If
            End If
        End If


        If strCboValue = "" Or strCboValue = "null" Then
            strCboValue = ""

        End If

        '' For Edit Mode
        strAllProductVersion = "->"
        strSQLQuery = " Exec usp_Sel_ProductVersions_AND_Components  " & strProjectID & "," & strCboValue & ",NULL," & "'ProductVersions'" & ",NULL"
        drProductVersions = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While drProductVersions.Read
            strProductVersionID = drProductVersions("ProductVersionID").ToString
            strProductVersion = drProductVersions("ProductVersion").ToString
            strAllProductVersion &= "|" & strProductVersion & "->" & strProductVersionID
        End While
        Response.ContentType = "text/html"

        If Not strAllProductVersion Is Nothing Then
            Response.Write(strAllProductVersion)
        Else
            Response.Write("null")
        End If

        CommonFunction.Data.DisposeDataReader(drProductVersions)


    End Function

    '' Select Customer Level Product Versions Components
    Public Function Display_CustomerLevel_ProductVersionComponents()

        Dim strSQLQuery, strDependentControlName, strCboValue, strComponentID, strComponent, strAllComponent As String
        Dim drProductVersionComponent As IDataReader


        If Not Request.QueryString.Get("DependentControlName") Is Nothing Then
            strDependentControlName = Request.QueryString.Get("DependentControlName").ToString
            If Not strDependentControlName = "" Then
                If Not Request.QueryString.Get("CboValue") Is Nothing Then
                    strCboValue = Request.QueryString.Get("CboValue").ToString
                End If
            End If
        End If

        If strCboValue = "" Then
            strCboValue = ""
        End If

        strAllComponent = "->"
        strSQLQuery = " Exec usp_Sel_ProductVersions_AND_Components " & strProjectID & "," & strCustomerControlValue & "," & strCboValue & ",NULL," & "'ProductVersions_Components'"
        drProductVersionComponent = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While drProductVersionComponent.Read
            strComponentID = drProductVersionComponent("ComponentID").ToString
            strComponent = drProductVersionComponent("Component").ToString
            strAllComponent &= "|" & strComponent & "->" & strComponentID
        End While

        Response.ContentType = "text/html"
        If Not strAllComponent Is Nothing Then
            Response.Write(strAllComponent)
        Else
            Response.Write("null")
        End If


        CommonFunctions.Data.DisposeDataReader(drProductVersionComponent)
    End Function
    '' Select Project Level Product Versions
    Public Function Display_ProjectLevel_ProductVersionsComponents()

        '' Added By ParagD On 24-May-2006
        Dim strSQLQuery, strDependentControlName, strCboValue, strComponentID, strComponent, strAllComponents As String
        Dim drProductVersionComponents As IDataReader



        If Not Request.QueryString.Get("DependentControlName") Is Nothing Then
            strDependentControlName = Request.QueryString.Get("DependentControlName").ToString
            If Not strDependentControlName = "" Then
                If Not Request.QueryString.Get("CboValue") Is Nothing Then
                    strCboValue = Request.QueryString.Get("CboValue").ToString
                End If
            End If
        End If

        If strCboValue = "" Then
            strCboValue = ""
        End If

        strAllComponents = "->"
        strSQLQuery = " Exec usp_Sel_ProductVersions_AND_Components " & strProjectID & ", NULL," & strCboValue & ",NULL," & "'ProductVersions_Components'"
        drProductVersionComponents = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While drProductVersionComponents.Read
            strComponentID = drProductVersionComponents("ComponentId").ToString
            strComponent = drProductVersionComponents("Component").ToString
            strAllComponents &= "|" & strComponent & "->" & strComponentID
        End While
        Response.ContentType = "text/html"

        Response.Write(strAllComponents)

        CommonFunction.Data.DisposeDataReader(drProductVersionComponents)
        '' END : Added By ParagD On 24-May-2006
    End Function


End Class
