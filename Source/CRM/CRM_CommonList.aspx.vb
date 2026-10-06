Public Partial Class CRM_CommonList
    Inherits CommonList

    'Refer this page for generic inheritance os CL.
    Private Const APP_TAG_CRM_STATUS_HISTORY As Long = 3991

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.strListPage = "CRM_CommonList.aspx"
        'MyBase.strFormPage = "CRM_CommonPage.aspx"

        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

        Select Case MyBase.m_objGlobal.TagID

            Case APP_TAG_CRM_STATUS_HISTORY
                Args.HTMLLegend = ""
                Cancel = True

        End Select


    End Sub


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cCRM_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

End Class

Public Class cCRM_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private Const APP_TAG_CRM_STATUS_HISTORY As Long = 3991


    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Select Case WhizGlobal.TagID
            Case APP_TAG_CRM_STATUS_HISTORY

                If Args.DataField = "ModifiedDateTime" Then
                    Dim dtModifiedDateTime As String

                    If IsDBNull(Args.DataReader("ModifiedDateTime")) Then
                        dtModifiedDateTime = "-"
                    Else
                        dtModifiedDateTime = CommonFunction.Dates.CGetDateTime(CType(Args.DataReader("ModifiedDateTime"), DateTime)).ToString()
                    End If


                    Cancel = True
                    Args.StringToBeInserted = "<TD align=left>" + dtModifiedDateTime + "</TD>"

                End If

           
        End Select


    End Sub

End Class