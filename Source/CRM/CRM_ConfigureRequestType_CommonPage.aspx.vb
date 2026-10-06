Imports CommonEngines.General.cEventHandlers



Public Class CRM_ConfigureRequestType_CommonPage
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
        MyBase.strListPage = "CRM_ConfigureRequestType_CommonList.aspx"
        MyBase.strFormPage = "CRM_ConfigureRequestType_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub



    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Dim strRequestTypeID As String = ""
        'strRequestTypeID = Request.QueryString("ReqTypeID").ToString
        'If Args.LinkName.ToUpper = "BACK" Then
        '    Args.ToBeInsertedInFunction = "var objfrm;" + vbCrLf
        '    'Args.ToBeInsertedInFunction = "var strvalidate;" + vbCrLf
        '    'Args.ToBeInsertedInFunction &= "strvalidate=" + strRequestTypeID + vbCrLf
        '    'Args.ToBeInsertedInFunction &= "if (strvalidate=='' || strvalidate==NULL){strvalidate=0}" + vbCrLf
        '    If strRequestTypeID = "" Or strRequestTypeID Is Nothing Then
        '        Args.ToBeInsertedInFunction &= "objfrm.action = ""../CRM/CRM_ConfigureRequestType_Commonlist.aspx?MasterTagID=3746&FunctionID=""+GetObjectReference('frmCommonPage','FunctionID').value+""&ReqTypeID=0""" + vbCrLf
        '    Else
        '        Args.ToBeInsertedInFunction &= "objfrm.action = '../CRM/CRM_ConfigureRequestType_Commonlist.aspx?MasterTagID=3746&FunctionID='+GetObjectReference('frmCommonPage','FunctionID').value+'&ReqTypeID= " + strRequestTypeID + vbCrLf
        '    End If
        '    'Args.ToBeInsertedInFunction &= "objfrm.action = '../CRM/CRM_ConfigureRequestType_Commonlist.aspx?MasterTagID=3746&FunctionID='+GetObjectReference('frmCommonPage','FunctionID').value+'&ReqTypeID=strvalidate " + vbCrLf
        '    'Args.ToBeInsertedInFunction &= "objfrm.action = '../CRM/CRM_ConfigureRequestType_Commonlist.aspx?MasterTagID=3746&FunctionID='+GetObjectReference('frmCommonPage','FunctionID').value+'&ReqTypeID=" & 10 & vbCrLf
        '    Args.ToBeInsertedInFunction &= "objfrm.submit();" + vbCrLf
        '    Args.ToBeInsertedInFunction &= "return;" + vbCrLf
        'End If

        'If Args.LinkName.ToUpper = "SAVE" Then
        '    Args.ToBeInsertedInFunction = "var objfrm;" + vbCrLf
        '    Args.ToBeInsertedInFunction &= "objfrm.action = ""../CRM/CRM_ConfigureRequestType_CommonPage.aspx?""" + vbCrLf
        '    Args.ToBeInsertedInFunction &= "objfrm.submit();" + vbCrLf
        '    Args.ToBeInsertedInFunction &= "return;" + vbCrLf
        'End If
    End Sub

   

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        If Not Request.QueryString("ReqTypeID") Is Nothing Then
            Response.Write("<input type=hidden name='hidReqTypeID' id='hidReqTypeID' value=" + Request.QueryString("ReqTypeID").ToString + " >")
        ElseIf Not Request.Form("hidReqTypeID") Is Nothing Then
            Response.Write("<input type=hidden name='hidReqTypeID' id='hidReqTypeID' value=" + Request.Form("hidReqTypeID").ToString + " >")
        End If
    End Function
End Class
