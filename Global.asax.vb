Imports System.Web

Public Class Global_asax
    Inherits WebPage.Templates.HttpApplicationTemplate

#Region " Component Designer Generated Code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Component Designer.  
        InitializeComponent()
        Dim str = CommonFunction.General.DecryptString("77-86-88-75-78-94-88-63-69-70-113-106-106-103-98-119-113-117-106-122-124-93-93-96-101-133-103")
        'Add any initialization after the InitializeComponent() call

    End Sub

    'Required by the Component Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Component Designer
    'It can be modified using the Component Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        components = New System.ComponentModel.Container()
    End Sub

#End Region

    Protected Overrides Sub Session_OnStart(sender As Object, e As EventArgs)
        MyBase.Session_OnStart(sender, e)

    End Sub
  
   
    Protected Overrides Sub SessionOnEnd(sender As Object, e As EventArgs)
        'MyBase.SessionOnEnd(sender, e)
        'If Session("intUserID") IsNot Nothing Then ' Added By Vaijat K
        '    If HashTables.Contains("ID" & Session("intUserID")) Then
        '        HashTables.Remove("ID" & Session("intUserID"))
        '    End If
        'End If
    End Sub

End Class