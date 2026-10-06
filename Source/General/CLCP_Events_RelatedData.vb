Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_RelatedData

            Public Shared Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur before plotting the Related Data Header
                Cancel = False

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            'added by SachinR   on 06 Sep 2004
                            'if Module and Sub Projects are not applicable to the project type then 
                            'hide those related data sections
                            Dim strProjectTypeID As String
                            Dim strSQL As String
                            Dim objDr As IDataReader
                            Dim blnIsApplicable As Boolean = False

                            If Args.OrderNumber = 3 Or Args.OrderNumber = 4 Then
                                strProjectTypeID = ""
                                strSQL = "usp_Sel_tbl_PM_Project " + WhizGlobal.ProjectID.ToString
                                objDr = CommonFunction.Data.GetDataReader(strSQL, True)
                                If objDr.Read Then
                                    strProjectTypeID = CommonFunction.Data.CheckIsDBNull(objDr("ProjectTypeID"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                strSQL = "usp_sel_tbl_PRS_ProjectPlans " + strProjectTypeID.Trim
                                If Args.OrderNumber = 3 Then
                                    strSQL += ",13"
                                Else
                                    strSQL += ",12"
                                End If
                                objDr = CommonFunction.Data.GetDataReader(strSQL, True)
                                If objDr.Read Then
                                    blnIsApplicable = True
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                If blnIsApplicable = False Then Cancel = True
                            End If
                            'addition end
                    End Select

                Else
                    'For Details Tag

                End If
            End Sub

            Public Shared Sub After_PlotRelatedDataHeader(ByVal Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur After plotting the Related Data Header

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag

                Else
                    'For Details Tag

                End If
            End Sub

            Public Shared Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur before plotting the Related Data Grid
                Cancel = False

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_PUBLISH
                            'added by SachinR   on 31 Jul 2004
                            'here datasource is changed for the grid to show the templates associated 
                            'with the phase task.Here PhasetaskID is taken from query string so SP can not 
                            'need to set datasource here
                            Dim strPhaseTaskID As String
                            strPhaseTaskID = HttpContext.Current.Request("PhaseTaskID") + ""
                            Args.GridSQL = "usp_Sel_TemplatesAssociatedWithPhaseTask " + strPhaseTaskID.Trim
                            Dim strACol() As String = {"Template Name"}
                            Args.ActualColumnArray = strACol
                            Args.NoOfDataColumns = 1
                            Dim strTDStyle() As String = {"align='left'"}
                            Args.TDStyleArray = strTDStyle
                            'Dim strUFCol() As String = {"Template Name"}
                            'Args.UserFriendlyColumnArray = strUFCol
                            'addition end

                            'added by SachinR   on 20 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_DISCUSSION_THREAD
                            If WhizGlobal.LoginType.ToUpper = "E" Then
                                Args.GridSQL += " AND ScheduleID=" + HttpContext.Current.Request.QueryString("ScheduleID").ToString + " Order By DiscussionDate DESC"
                            Else
                                Args.GridSQL += " AND ScheduleID=" + HttpContext.Current.Request.QueryString("ScheduleID").ToString + " AND ShowToCustomer = 1 Order By DiscussionDate DESC"
                            End If
                            'addition end

                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            'added by SachinR   on 06 Sep 2004
                            'if Module and Sub Projects are not applicable to the project type then 
                            'hide those related data sections
                            Dim strProjectTypeID As String
                            Dim strSQL As String
                            Dim objDr As IDataReader
                            Dim blnIsApplicable As Boolean = False

                            If Args.OrderNumber = 3 Or Args.OrderNumber = 4 Then
                                strProjectTypeID = ""
                                strSQL = "usp_Sel_tbl_PM_Project " + WhizGlobal.ProjectID.ToString
                                objDr = CommonFunction.Data.GetDataReader(strSQL, True)
                                If objDr.Read Then
                                    strProjectTypeID = CommonFunction.Data.CheckIsDBNull(objDr("ProjectTypeID"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                strSQL = "usp_sel_tbl_PRS_ProjectPlans " + strProjectTypeID.Trim
                                If Args.OrderNumber = 3 Then
                                    strSQL += ",13"
                                Else
                                    strSQL += ",12"
                                End If
                                objDr = CommonFunction.Data.GetDataReader(strSQL, True)
                                If objDr.Read Then
                                    blnIsApplicable = True
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                If blnIsApplicable = False Then Cancel = True
                            End If

                            'addition end

                    End Select
                Else
                    'For Details Tag

                End If
            End Sub

            Public Shared Sub After_PlotRelatedDataGrid(ByVal Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur After plotting the Related Data Grid

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag

                Else
                    'For Details Tag

                End If
            End Sub
            '_________Added By UmeshJ on July 12, 2004__________
            Public Shared Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

            End Sub
            Public Shared Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

            End Sub
            Public Shared Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        'added by SachinR   on 20 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_DISCUSSION_THREAD
                            If Args.DataField.ToUpper = "DATE" Then
                                Args.ShowTimeWithDate = True
                            ElseIf Args.DataField.ToUpper = "COMMENTS" Then
                                Args.StringToBeInserted = "<TD><PRE>" & Args.DataReader("COMMENTS").ToString & "</PRE></TD>"
                                Cancel = True
                            End If
                            'addition end

                    End Select
                Else
                    'For Details Tag

                End If
            End Sub
            Public Shared Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

            End Sub
            Public Shared Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

            End Sub
            Public Shared Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

            End Sub
            'End of Addition____________________________________
        End Class
    End Namespace
End Namespace
