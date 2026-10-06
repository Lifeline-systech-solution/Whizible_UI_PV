Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_HeaderFooter

            Public Shared Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As EventHandlers.WAF_General)
                Cancel = False
                'This Event will occur before printing page header footer
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
            End Sub
        End Class
    End Namespace
End Namespace
