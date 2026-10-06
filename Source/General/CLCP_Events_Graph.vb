Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_Graph

            Public Shared Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur before plotting the Graph

                If Args.ChartType(0).ToUpper = "LINE" Then
                    Args.ShowCaptions = False
                    Args.EnableSmartLabels = False
                End If

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                    End Select
                Else
                    'For Details Tag

                End If
            End Sub

            Public Shared Sub After_PlotGraph(ByVal Args As EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur After plotting the Graph

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag

                Else
                    'For Details Tag

                End If
            End Sub
        End Class
    End Namespace
End Namespace
