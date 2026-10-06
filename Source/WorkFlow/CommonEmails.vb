Imports WorkFlowCommonEngine.DefinationStructures
Imports WorkFlowCommonEngine.DefinitionTables
Imports WorkFlowCommonEngine.HashTables.GetProcessDefinitionHashTablesObject

Namespace WorkFlows

    Public Class CommonEmails

        Public Shared Sub SubmitSilentMail(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCEmailID As String, ByRef Subject As String, ByRef Message As String, ByVal e As WorkflowEmails, ByVal InstanceID As String, ByVal Args As WAF_ProcessStageDetails, ByVal PrimaryKeyValue As String)
            Dim objProcessStages() As WorkFlowCommonEngine.DefinitionTables.ProcessStage
            Dim objProcess As WorkFlowCommonEngine.DefinitionTables.Process
            Dim intCounter As Integer
            Dim drApprovers As IDataReader
            Dim drEmailID As IDataReader
            Dim sbEmailID As New System.Text.StringBuilder
            Dim strApprovers As String
            Dim strSQL As String
            Dim strNotifiables As String
            Dim intSysCounter As Integer

            Try
                objProcess = GetProcessMasterHashTableObject(Args.ProcessID)
                objProcessStages = GetProcessStageHashTableObject(Args.ProcessID)
                For intCounter = 0 To objProcessStages.Length - 1
                    If objProcessStages(intCounter).StageID = Args.NextStageID Then
                        If objProcessStages(intCounter).StageType = StageTypes.STG_SYSTEM Or objProcessStages(intCounter).StageType = StageTypes.STG_TIME Then
                            intCounter = intCounter + 1
                            For intSysCounter = intCounter To objProcessStages.Length - 1
                                If objProcessStages(intSysCounter).StageType <> StageTypes.STG_SYSTEM Then
                                    Exit For
                                End If
                            Next
                            intCounter = intSysCounter
                        End If
                        Exit For
                    End If
                Next
                If objProcessStages(intCounter).IsStaticApprovers = True Then
                    strApprovers = objProcessStages(intCounter).ApproversList
                Else
                    strSQL = objProcessStages(intCounter).ApproversList
                    strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                    drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strApprovers = ""
                    While drApprovers.Read
                        strApprovers = strApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                    End While
                    drApprovers.Close()
                    CommonFunction.Data.DisposeDataReader(drApprovers)
                End If

                If objProcessStages(intCounter).IsStaticNotifiables = True Then
                    strNotifiables = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                Else
                    strSQL = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                    If strSQL <> "" Then
                        strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                        drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        strNotifiables = ""
                        While drApprovers.Read
                            strNotifiables = strNotifiables + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                        End While
                        drApprovers.Close()
                        CommonFunction.Data.DisposeDataReader(drApprovers)
                    End If
                End If
                If strApprovers.LastIndexOf(",") = strApprovers.Length - 1 Then
                    strApprovers = strApprovers.Remove(strApprovers.Length - 1, 1)
                End If

                If strNotifiables <> "" Then
                    If strNotifiables.LastIndexOf(",") = strNotifiables.Length - 1 Then
                        strNotifiables = strNotifiables.Remove(strNotifiables.Length - 1, 1)
                    End If
                End If

                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                End While
                drEmailID.Close()

                e.MailTo = e.MailTo.Replace("<NEXT_LEVEL_APPROVER_EMAILID>", sbEmailID.ToString)
                sbEmailID.Remove(0, sbEmailID.Length - 1)

                If strNotifiables <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNotifiables + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    e.MailCC = e.MailCC.Replace("<NOTIFY_EMAILID>", sbEmailID.ToString)
                Else
                    e.MailCC = e.MailCC.Replace("<NOTIFY_EMAILID>", "")
                End If

                CommonFunctions.Data.DisposeDataReader(drEmailID)

                e.MailFrom = e.MailFrom.Replace("<SUBMITTER_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + Args.UserID.ToString + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)
                e.MailCC = e.MailCC.Replace("<SUBMITTER_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + Args.UserID.ToString + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)
                e.Subject = e.Subject.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                e.Body = e.Body.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                e.Body = e.Body.Replace("<CREATED_DATETIME>", Now.ToString)
                e.Body = e.Body.Replace("<SUBMITTER_NAME>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
                ToEmailID = e.MailTo
                FromEmailID = e.MailFrom
                CCEmailID = e.MailCC
                Subject = e.Subject
                Message = e.Body
            Catch ex As Exception

            Finally
                objProcessStages = Nothing
                objProcess = Nothing
            End Try
        End Sub

        Public Shared Sub ReSubmitSilentMail(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCEmailID As String, ByRef Subject As String, ByRef Message As String, ByVal e As WorkflowEmails, ByVal InstanceID As String, ByVal Args As WAF_ProcessStageDetails, ByVal PrimaryKeyValue As String)
            Dim objProcessStages() As WorkFlowCommonEngine.DefinitionTables.ProcessStage
            Dim objProcess As WorkFlowCommonEngine.DefinitionTables.Process
            Dim intCounter As Integer
            Dim drApprovers As IDataReader
            Dim drEmailID As IDataReader
            Dim sbEmailID As New System.Text.StringBuilder
            Dim strApprovers As String
            Dim strSQL As String
            Dim strNotifiables As String
            Dim intSysCounter As Integer

            Try
                objProcess = GetProcessMasterHashTableObject(Args.ProcessID)
                objProcessStages = GetProcessStageHashTableObject(Args.ProcessID)
                For intCounter = 0 To objProcessStages.Length - 1
                    If objProcessStages(intCounter).StageID = Args.NextStageID Then
                        If objProcessStages(intCounter).StageType = StageTypes.STG_SYSTEM Or objProcessStages(intCounter).StageType = StageTypes.STG_TIME Then
                            intCounter = intCounter + 1
                            For intSysCounter = intCounter To objProcessStages.Length - 1
                                If objProcessStages(intSysCounter).StageType <> StageTypes.STG_SYSTEM Then
                                    Exit For
                                End If
                            Next
                            intCounter = intSysCounter
                        End If
                        Exit For
                    End If
                Next
                If objProcessStages(intCounter).IsStaticApprovers = True Then
                    strApprovers = objProcessStages(intCounter).ApproversList
                Else
                    strSQL = objProcessStages(intCounter).ApproversList
                    strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                    drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strApprovers = ""
                    While drApprovers.Read
                        strApprovers = strApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                    End While
                    drApprovers.Close()
                    CommonFunction.Data.DisposeDataReader(drApprovers)
                End If

                If objProcessStages(intCounter).IsStaticNotifiables = True Then
                    strNotifiables = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                Else
                    strSQL = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                    If strSQL <> "" Then
                        strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                        drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        strNotifiables = ""
                        While drApprovers.Read
                            strNotifiables = strNotifiables + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                        End While
                        drApprovers.Close()
                        CommonFunction.Data.DisposeDataReader(drApprovers)
                    End If
                End If
                If strApprovers.LastIndexOf(",") = strApprovers.Length - 1 Then
                    strApprovers = strApprovers.Remove(strApprovers.Length - 1, 1)
                End If

                If strNotifiables <> "" Then
                    If strNotifiables.LastIndexOf(",") = strNotifiables.Length - 1 Then
                        strNotifiables = strNotifiables.Remove(strNotifiables.Length - 1, 1)
                    End If
                End If

                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                End While
                drEmailID.Close()

                e.MailTo = e.MailTo.Replace("<NEXT_LEVEL_APPROVER_EMAILID>", sbEmailID.ToString)
                sbEmailID.Remove(0, sbEmailID.Length - 1)

                If strNotifiables <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNotifiables + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    e.MailCC = e.MailCC.Replace("<NOTIFY_EMAILID>", sbEmailID.ToString)
                Else
                    e.MailCC = e.MailCC.Replace("<NOTIFY_EMAILID>", "")
                End If

                CommonFunctions.Data.DisposeDataReader(drEmailID)

                e.MailFrom = e.MailFrom.Replace("<SUBMITTER_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + Args.UserID.ToString + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)
                e.MailCC = e.MailCC.Replace("<SUBMITTER_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + Args.UserID.ToString + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)
                e.Subject = e.Subject.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                e.Body = e.Body.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                e.Body = e.Body.Replace("<CREATED_DATETIME>", Now.ToString)
                e.Body = e.Body.Replace("<SUBMITTER_NAME>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
                ToEmailID = e.MailTo
                FromEmailID = e.MailFrom
                CCEmailID = e.MailCC
                Subject = e.Subject
                Message = e.Body
            Catch ex As Exception

            Finally
                objProcessStages = Nothing
                objProcess = Nothing
            End Try
        End Sub

        Public Shared Sub ApproveSilentMail(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCEmailID As String, ByRef Subject As String, ByRef Message As String, ByVal e As WorkflowEmails, ByVal InstanceID As String, ByVal Args As WAF_ProcessStageDetails, ByVal PrimaryKeyValue As String)
            Dim objProcessStages() As WorkFlowCommonEngine.DefinitionTables.ProcessStage
            Dim objProcess As WorkFlowCommonEngine.DefinitionTables.Process
            Dim intCounter As Integer
            Dim drApprovers As IDataReader
            Dim drEmailID As IDataReader
            Dim drStages As IDataReader
            Dim sbEmailID As New System.Text.StringBuilder
            Dim strApprovers As String
            Dim strNextApprovers As String
            Dim strCurrentApprovers As String
            Dim strSQL As String
            Dim strSubmitStage As String
            Dim strSubmitter As String
            Dim strSubmitterName As String
            Dim strSubmitionDateTime As String
            Dim strStageName As String
            Dim strNotifiables As String
            Dim intSysCounter As Integer

            Try
                objProcess = GetProcessMasterHashTableObject(Args.ProcessID)
                objProcessStages = GetProcessStageHashTableObject(Args.ProcessID)
                strSubmitStage = objProcessStages(0).StageID

                drStages = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_WF_Event '" + InstanceID + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                strApprovers = ""
                strNextApprovers = ""
                strCurrentApprovers = ""
                While drStages.Read
                    For intCounter = 0 To objProcessStages.Length - 1
                        If UCase(strSubmitStage) <> UCase(objProcessStages(intCounter).StageID) Then
                            If UCase(objProcessStages(intCounter).StageID) = UCase(drStages("FromStageID").ToString) Or UCase(objProcessStages(intCounter).StageID) = UCase(Args.NextStageID) Then
                                If objProcessStages(intCounter).StageType = StageTypes.STG_SYSTEM Or objProcessStages(intCounter).StageType = StageTypes.STG_TIME Then
                                    intCounter = intCounter + 1
                                    For intSysCounter = intCounter To objProcessStages.Length - 1
                                        If objProcessStages(intSysCounter).StageType <> StageTypes.STG_SYSTEM Then
                                            Exit For
                                        End If
                                    Next
                                    intCounter = intSysCounter
                                End If
                                Exit For
                            End If
                        Else
                            If UCase(strSubmitStage) = UCase(drStages("FromStageID").ToString) Then
                                strSubmitter = drStages("UserID").ToString
                                strSubmitionDateTime = drStages("EventTime").ToString
                            End If
                        End If
                    Next

                    If intCounter <= objProcessStages.Length - 1 Then
                        If objProcessStages(intCounter).IsStaticApprovers = True Then
                            If UCase(objProcessStages(intCounter).StageID) = UCase(Args.NextStageID) Then
                                If InStr(strNextApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strNextApprovers = strNextApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            ElseIf UCase(objProcessStages(intCounter).StageID) = UCase(Args.StageID) Then
                                strStageName = objProcessStages(intCounter).StageName
                                If InStr(strCurrentApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strCurrentApprovers = strCurrentApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            Else
                                If InStr(strApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strApprovers = strApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            End If
                        Else
                            strSQL = objProcessStages(intCounter).ApproversList
                            strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                            drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            While drApprovers.Read
                                If UCase(objProcessStages(intCounter).StageID) = UCase(Args.NextStageID) Then
                                    strNextApprovers = strNextApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                ElseIf UCase(objProcessStages(intCounter).StageID) = UCase(Args.StageID) Then
                                    strStageName = objProcessStages(intCounter).StageName
                                    strCurrentApprovers = strCurrentApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                Else
                                    strApprovers = strApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                End If
                            End While
                            drApprovers.Close()
                            CommonFunction.Data.DisposeDataReader(drApprovers)
                        End If
                        If objProcessStages(intCounter).IsStaticNotifiables = True Then
                            strNotifiables = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                        Else
                            strSQL = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                            If strSQL <> "" Then
                                strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                                drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strNotifiables = ""
                                While drApprovers.Read
                                    strNotifiables = strNotifiables + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                End While
                                drApprovers.Close()
                                CommonFunction.Data.DisposeDataReader(drApprovers)
                            End If
                        End If
                    End If
                End While
                drStages.Close()
                CommonFunctions.Data.DisposeDataReader(drStages)

                If strApprovers <> "" Then
                    If strApprovers.LastIndexOf(",") = strApprovers.Length - 1 Then
                        strApprovers = strApprovers.Remove(strApprovers.Length - 1, 1)
                    End If
                End If

                If strNextApprovers.LastIndexOf(",") = strNextApprovers.Length - 1 Then
                    strNextApprovers = strNextApprovers.Remove(strNextApprovers.Length - 1, 1)
                End If

                If strCurrentApprovers.LastIndexOf(",") = strCurrentApprovers.Length - 1 Then
                    strCurrentApprovers = strCurrentApprovers.Remove(strCurrentApprovers.Length - 1, 1)
                End If

                If strNotifiables <> "" Then
                    If strNotifiables.LastIndexOf(",") = strNotifiables.Length - 1 Then
                        strNotifiables = strNotifiables.Remove(strNotifiables.Length - 1, 1)
                    End If
                End If

                e.MailFrom = e.MailFrom.Replace("<APPROVERS_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)

                If strApprovers <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    e.MailTo = e.MailTo.Replace("<PREVIOUS_LEVEL_AAPROVER_EMAILID>", sbEmailID.ToString)
                    sbEmailID.Remove(0, sbEmailID.Length - 1)
                Else
                    e.MailTo = e.MailTo.Replace("<PREVIOUS_LEVEL_AAPROVER_EMAILID>", "")
                End If

                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strSubmitter + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    strSubmitterName = drEmailID("EmployeeName").ToString
                End While
                drEmailID.Close()
                e.MailTo = e.MailTo.Replace("<SUBMITTER_EMAILID>", sbEmailID.ToString)

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNextApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                End While
                drEmailID.Close()
                e.MailCC = e.MailCC.Replace("<NEXT_LEVEL_APPROVER_EMAILID>", sbEmailID.ToString)

                sbEmailID.Remove(0, sbEmailID.Length - 1)
                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strCurrentApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                End While
                drEmailID.Close()
                e.MailCC = e.MailCC.Replace("<CURRENT_APPROVER_EMAILID>", sbEmailID.ToString)

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                If strNotifiables <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNotifiables + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    e.MailCC = e.MailCC.Replace("<NOTIFY_EMAILID>", sbEmailID.ToString)
                Else
                    e.MailCC = e.MailCC.Replace("<NOTIFY_EMAILID>", "")
                End If
                CommonFunctions.Data.DisposeDataReader(drEmailID)

                e.Subject = e.Subject.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                e.Body = e.Body.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                e.Body = e.Body.Replace("<APPROVED_DATETIME>", Now.ToString)
                e.Body = e.Body.Replace("<CREATED_DATETIME>", strSubmitionDateTime)
                e.Body = e.Body.Replace("<APPROVER_NAME>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
                e.Body = e.Body.Replace("<SUBMITTER_NAME>", strSubmitterName)
                e.Body = e.Body.Replace("<STAGE_NAME>", strStageName)
                ToEmailID = e.MailTo
                FromEmailID = e.MailFrom
                CCEmailID = e.MailCC
                Subject = e.Subject
                Message = e.Body
            Catch ex As Exception

            Finally
                objProcessStages = Nothing
                objProcess = Nothing
            End Try
        End Sub

        Public Shared Sub RejectSilentMail(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCEmailID As String, ByRef Subject As String, ByRef Message As String, ByVal e As WorkflowEmails, ByVal InstanceID As String, ByVal Args As WAF_ProcessStageDetails, ByVal PrimaryKeyValue As String)
            Dim objProcessStages() As WorkFlowCommonEngine.DefinitionTables.ProcessStage
            Dim objProcess As WorkFlowCommonEngine.DefinitionTables.Process
            Dim intCounter As Integer
            Dim drApprovers As IDataReader
            Dim drEmailID As IDataReader
            Dim drStages As IDataReader
            Dim sbEmailID As New System.Text.StringBuilder
            Dim strApprovers As String = ""
            Dim strNextApprovers As String = ""
            Dim strCurrentApprovers As String = ""
            Dim strSQL As String
            Dim strSubmitStage As String
            Dim strSubmitter As String
            Dim strSubmitterName As String
            Dim strSubmitionDateTime As String
            Dim strStageName As String
            Dim strComments As String
            Dim strNotifiables As String
            Dim intSysCounter As Integer

            Try
                objProcess = GetProcessMasterHashTableObject(Args.ProcessID)
                objProcessStages = GetProcessStageHashTableObject(Args.ProcessID)
                strSubmitStage = objProcessStages(0).StageID

                drStages = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_WF_Event '" + InstanceID + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                strApprovers = ""
                strNextApprovers = ""
                strCurrentApprovers = ""
                While drStages.Read
                    For intCounter = 0 To objProcessStages.Length - 1
                        If UCase(strSubmitStage) <> UCase(objProcessStages(intCounter).StageID) Then
                            If UCase(objProcessStages(intCounter).StageID) = UCase(drStages("FromStageID").ToString) Or UCase(objProcessStages(intCounter).StageID) = UCase(Args.NextStageID) Then
                                If objProcessStages(intCounter).StageType = StageTypes.STG_SYSTEM Or objProcessStages(intCounter).StageType = StageTypes.STG_TIME Then
                                    intCounter = intCounter + 1
                                    For intSysCounter = intCounter To objProcessStages.Length - 1
                                        If objProcessStages(intSysCounter).StageType <> StageTypes.STG_SYSTEM Then
                                            Exit For
                                        End If
                                    Next
                                    intCounter = intSysCounter
                                End If
                                Exit For
                            End If
                        Else
                            If UCase(strSubmitStage) = UCase(drStages("FromStageID").ToString) Then
                                strSubmitter = drStages("UserID").ToString
                                strSubmitionDateTime = drStages("EventTime").ToString
                            End If
                        End If
                    Next

                    If intCounter <= objProcessStages.Length - 1 Then
                        If objProcessStages(intCounter).IsStaticApprovers = True Then
                            If UCase(objProcessStages(intCounter).StageID) = UCase(Args.StageID) Then
                                strStageName = objProcessStages(intCounter).StageName
                                strComments = CommonFunctions.General.CheckIsNothing(drStages("Comments"), "")
                                If InStr(strCurrentApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strCurrentApprovers = strCurrentApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            Else
                                If InStr(strApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strApprovers = strApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            End If
                        Else
                            strSQL = objProcessStages(intCounter).ApproversList
                            If strSQL <> "" Then
                                strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                                drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drApprovers.Read
                                    If UCase(objProcessStages(intCounter).StageID) = UCase(Args.StageID) Then
                                        strStageName = objProcessStages(intCounter).StageName
                                        strComments = CommonFunctions.General.CheckIsNothing(drStages("Comments"), "")
                                        strCurrentApprovers = strCurrentApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                    Else
                                        strApprovers = strApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                    End If
                                End While
                                drApprovers.Close()
                                CommonFunction.Data.DisposeDataReader(drApprovers)
                            End If
                        End If
                        If objProcessStages(intCounter).IsStaticNotifiables = True Then
                            strNotifiables = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                        Else
                            strSQL = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                            If strSQL <> "" Then
                                strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                                drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strNotifiables = ""
                                While drApprovers.Read
                                    strNotifiables = strNotifiables + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                End While
                                drApprovers.Close()
                                CommonFunction.Data.DisposeDataReader(drApprovers)
                            End If
                        End If
                    End If
                End While
                drStages.Close()
                CommonFunctions.Data.DisposeDataReader(drStages)

                If strApprovers <> "" Then
                    If strApprovers.LastIndexOf(",") = strApprovers.Length - 1 Then
                        strApprovers = strApprovers.Remove(strApprovers.Length - 1, 1)
                    End If
                End If

                If strCurrentApprovers <> "" Then
                    If strCurrentApprovers.LastIndexOf(",") = strCurrentApprovers.Length - 1 Then
                        strCurrentApprovers = strCurrentApprovers.Remove(strCurrentApprovers.Length - 1, 1)
                    End If
                End If

                If strNotifiables <> "" Then
                    If strNotifiables.LastIndexOf(",") = strNotifiables.Length - 1 Then
                        strNotifiables = strNotifiables.Remove(strNotifiables.Length - 1, 1)
                    End If
                End If

                e.MailFrom = e.MailFrom.Replace("<APPROVERS_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)

                If strApprovers <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    e.MailTo = e.MailTo.Replace("<PREVIOUS_LEVEL_AAPROVER_EMAILID>", sbEmailID.ToString)
                    sbEmailID.Remove(0, sbEmailID.Length - 1)
                Else
                    e.MailTo = e.MailTo.Replace("<PREVIOUS_LEVEL_AAPROVER_EMAILID>", "")
                End If

                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strSubmitter + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    strSubmitterName = drEmailID("EmployeeName").ToString
                End While
                drEmailID.Close()
                e.MailTo = e.MailTo.Replace("<SUBMITTER_EMAILID>", sbEmailID.ToString)

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                If strCurrentApprovers <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strCurrentApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    e.MailCC = e.MailCC.Replace("<CURRENT_APPROVER_EMAILID>", sbEmailID.ToString)
                Else
                    e.MailCC = e.MailCC.Replace("<CURRENT_APPROVER_EMAILID>", "")
                End If

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                If strNotifiables <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNotifiables + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    e.MailCC = e.MailCC.Replace("<NOTIFY_EMAILID>", sbEmailID.ToString)
                Else
                    e.MailCC = e.MailCC.Replace("<NOTIFY_EMAILID>", "")
                End If
                CommonFunctions.Data.DisposeDataReader(drEmailID)

                e.Subject = e.Subject.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                e.Body = e.Body.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                e.Body = e.Body.Replace("<REJECTED_DATETIME>", Now.ToString)
                e.Body = e.Body.Replace("<CREATED_DATETIME>", strSubmitionDateTime)
                e.Body = e.Body.Replace("<APPROVER_NAME>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
                e.Body = e.Body.Replace("<SUBMITTER_NAME>", strSubmitterName)
                e.Body = e.Body.Replace("<STAGE_NAME>", strStageName)
                e.Body = e.Body.Replace("<REJECTION_REASON>", strComments)
                ToEmailID = e.MailTo
                FromEmailID = e.MailFrom
                CCEmailID = e.MailCC
                Subject = e.Subject
                Message = e.Body
            Catch ex As Exception

            Finally
                objProcessStages = Nothing
                objProcess = Nothing
            End Try
        End Sub

        Public Shared Sub SubmitMail(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCEmailID As String, ByRef Subject As String, ByRef Message As String, ByVal InstanceID As String, ByVal ProcessID As String, ByVal NextStageID As String, ByVal PrimaryKeyValue As String)
            Dim objProcessStages() As WorkFlowCommonEngine.DefinitionTables.ProcessStage
            Dim objProcess As WorkFlowCommonEngine.DefinitionTables.Process
            Dim intCounter As Integer
            Dim intSysCounter As Integer
            Dim drApprovers As IDataReader
            Dim drEmailID As IDataReader
            Dim sbEmailID As New System.Text.StringBuilder
            Dim strApprovers As String
            Dim strNotifiables As String
            Dim strSQL As String
            Dim objE As New WorkFlowCommonEngine.DefinationStructures.WorkflowEmails

            Try
                objProcess = GetProcessMasterHashTableObject(ProcessID)
                objProcessStages = GetProcessStageHashTableObject(ProcessID)
                For intCounter = 0 To objProcessStages.Length - 1
                    If objProcessStages(intCounter).StageID = NextStageID Then
                        If objProcessStages(intCounter).StageType = StageTypes.STG_SYSTEM Or objProcessStages(intCounter).StageType = StageTypes.STG_TIME Then
                            intCounter = intCounter + 1
                            For intSysCounter = intCounter To objProcessStages.Length - 1
                                If objProcessStages(intSysCounter).StageType <> StageTypes.STG_SYSTEM Then
                                    Exit For
                                End If
                            Next
                            intCounter = intSysCounter
                        End If
                        Exit For
                    End If
                Next
                If objProcessStages(intCounter).IsStaticApprovers = True Then
                    strApprovers = objProcessStages(intCounter).ApproversList
                Else
                    strSQL = objProcessStages(intCounter).ApproversList
                    strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                    drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strApprovers = ""
                    While drApprovers.Read
                        strApprovers = strApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                    End While
                    drApprovers.Close()
                    CommonFunction.Data.DisposeDataReader(drApprovers)
                End If
                If objProcessStages(intCounter).IsStaticNotifiables = True Then
                    strNotifiables = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                Else
                    strSQL = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                    If strSQL <> "" Then
                        strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                        drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        strNotifiables = ""
                        While drApprovers.Read
                            strNotifiables = strNotifiables + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                        End While
                        drApprovers.Close()
                        CommonFunction.Data.DisposeDataReader(drApprovers)
                    End If
                End If

                If strApprovers.LastIndexOf(",") = strApprovers.Length - 1 Then
                    strApprovers = strApprovers.Remove(strApprovers.Length - 1, 1)
                End If

                If strNotifiables <> "" Then
                    If strNotifiables.LastIndexOf(",") = strNotifiables.Length - 1 Then
                        strNotifiables = strNotifiables.Remove(strNotifiables.Length - 1, 1)
                    End If
                End If


                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                End While
                drEmailID.Close()

                GetEmailDetail(objE, "SUBMIT")

                objE.MailTo = objE.MailTo.Replace("<NEXT_LEVEL_APPROVER_EMAILID>", sbEmailID.ToString)
                sbEmailID.Remove(0, sbEmailID.Length - 1)

                If strNotifiables <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNotifiables + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailCC = objE.MailCC.Replace("<NOTIFY_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailCC = objE.MailCC.Replace("<NOTIFY_EMAILID>", "")
                End If
                CommonFunctions.Data.DisposeDataReader(drEmailID)

                objE.MailFrom = objE.MailFrom.Replace("<SUBMITTER_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)
                objE.MailCC = objE.MailCC.Replace("<SUBMITTER_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)
                objE.Subject = objE.Subject.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                objE.Body = objE.Body.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                objE.Body = objE.Body.Replace("<CREATED_DATETIME>", Now.ToString)
                objE.Body = objE.Body.Replace("<SUBMITTER_NAME>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
                ToEmailID = objE.MailTo
                FromEmailID = objE.MailFrom
                CCEmailID = objE.MailCC
                Subject = objE.Subject
                Message = objE.Body
            Catch ex As Exception

            Finally
                objProcessStages = Nothing
                objProcess = Nothing
            End Try
        End Sub

        Public Shared Sub ReSubmitMail(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCEmailID As String, ByRef Subject As String, ByRef Message As String, ByVal InstanceID As String, ByVal ProcessID As String, ByVal NextStageID As String, ByVal PrimaryKeyValue As String)
            Dim objProcessStages() As WorkFlowCommonEngine.DefinitionTables.ProcessStage
            Dim objProcess As WorkFlowCommonEngine.DefinitionTables.Process
            Dim intCounter As Integer
            Dim drApprovers As IDataReader
            Dim drEmailID As IDataReader
            Dim sbEmailID As New System.Text.StringBuilder
            Dim strApprovers As String
            Dim strNotifiables As String
            Dim strSQL As String
            Dim objE As New WorkFlowCommonEngine.DefinationStructures.WorkflowEmails
            Dim intSysCounter As Integer

            Try
                objProcess = GetProcessMasterHashTableObject(ProcessID)
                objProcessStages = GetProcessStageHashTableObject(ProcessID)
                For intCounter = 0 To objProcessStages.Length - 1
                    If objProcessStages(intCounter).StageID = NextStageID Then
                        If objProcessStages(intCounter).StageType = StageTypes.STG_SYSTEM Or objProcessStages(intCounter).StageType = StageTypes.STG_TIME Then
                            intCounter = intCounter + 1
                            For intSysCounter = intCounter To objProcessStages.Length - 1
                                If objProcessStages(intSysCounter).StageType <> StageTypes.STG_SYSTEM Then
                                    Exit For
                                End If
                            Next
                            intCounter = intSysCounter
                        End If
                        Exit For
                    End If
                Next
                If objProcessStages(intCounter).IsStaticApprovers = True Then
                    strApprovers = objProcessStages(intCounter).ApproversList
                Else
                    strSQL = objProcessStages(intCounter).ApproversList
                    strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                    drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strApprovers = ""
                    While drApprovers.Read
                        strApprovers = strApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                    End While
                    drApprovers.Close()
                    CommonFunction.Data.DisposeDataReader(drApprovers)
                End If
                If objProcessStages(intCounter).IsStaticNotifiables = True Then
                    strNotifiables = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                Else
                    strSQL = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                    If strSQL <> "" Then
                        strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                        drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        strNotifiables = ""
                        While drApprovers.Read
                            strNotifiables = strNotifiables + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                        End While
                        drApprovers.Close()
                        CommonFunction.Data.DisposeDataReader(drApprovers)
                    End If
                End If

                If strApprovers.LastIndexOf(",") = strApprovers.Length - 1 Then
                    strApprovers = strApprovers.Remove(strApprovers.Length - 1, 1)
                End If

                If strNotifiables <> "" Then
                    If strNotifiables.LastIndexOf(",") = strNotifiables.Length - 1 Then
                        strNotifiables = strNotifiables.Remove(strNotifiables.Length - 1, 1)
                    End If
                End If


                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                End While
                drEmailID.Close()

                GetEmailDetail(objE, "RESUBMIT")

                objE.MailTo = objE.MailTo.Replace("<NEXT_LEVEL_APPROVER_EMAILID>", sbEmailID.ToString)
                sbEmailID.Remove(0, sbEmailID.Length - 1)

                If strNotifiables <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNotifiables + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailCC = objE.MailCC.Replace("<NOTIFY_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailCC = objE.MailCC.Replace("<NOTIFY_EMAILID>", "")
                End If
                CommonFunctions.Data.DisposeDataReader(drEmailID)

                objE.MailFrom = objE.MailFrom.Replace("<SUBMITTER_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)
                objE.MailCC = objE.MailCC.Replace("<SUBMITTER_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)
                objE.Subject = objE.Subject.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                objE.Body = objE.Body.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                objE.Body = objE.Body.Replace("<CREATED_DATETIME>", Now.ToString)
                objE.Body = objE.Body.Replace("<SUBMITTER_NAME>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
                ToEmailID = objE.MailTo
                FromEmailID = objE.MailFrom
                CCEmailID = objE.MailCC
                Subject = objE.Subject
                Message = objE.Body
            Catch ex As Exception

            Finally
                objProcessStages = Nothing
                objProcess = Nothing
            End Try
        End Sub

        Public Shared Sub ApproveMail(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCEmailID As String, ByRef Subject As String, ByRef Message As String, ByVal InstanceID As String, ByVal ProcessID As String, ByVal NextStageID As String, ByVal CurrentStageID As String, ByVal PrimaryKeyValue As String)
            Dim objProcessStages() As WorkFlowCommonEngine.DefinitionTables.ProcessStage
            Dim objProcess As WorkFlowCommonEngine.DefinitionTables.Process
            Dim intCounter As Integer
            Dim drApprovers As IDataReader
            Dim drEmailID As IDataReader
            Dim drStages As IDataReader
            Dim sbEmailID As New System.Text.StringBuilder
            Dim strApprovers As String = ""
            Dim strNextApprovers As String = ""
            Dim strCurrentApprovers As String = ""
            Dim strSQL As String
            Dim strSubmitStage As String
            Dim objE As New WorkFlowCommonEngine.DefinationStructures.WorkflowEmails
            Dim strSubmitter As String
            Dim strSubmitterName As String
            Dim strSubmitionDateTime As String
            Dim strStageName As String
            Dim strNotifiables As String
            Dim intSysCounter As Integer

            Try
                objProcess = GetProcessMasterHashTableObject(ProcessID)
                objProcessStages = GetProcessStageHashTableObject(ProcessID)
                strSubmitStage = objProcessStages(0).StageID

                drStages = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_WF_Event '" + InstanceID + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                strApprovers = ""
                strNextApprovers = ""
                strCurrentApprovers = ""
                While drStages.Read
                    For intCounter = 0 To objProcessStages.Length - 1
                        If UCase(strSubmitStage) <> UCase(objProcessStages(intCounter).StageID) Then
                            If UCase(objProcessStages(intCounter).StageID) = UCase(drStages("FromStageID").ToString) Or UCase(objProcessStages(intCounter).StageID) = UCase(NextStageID) Then
                                If objProcessStages(intCounter).StageType = StageTypes.STG_SYSTEM Or objProcessStages(intCounter).StageType = StageTypes.STG_TIME Then
                                    intCounter = intCounter + 1
                                    For intSysCounter = intCounter To objProcessStages.Length - 1
                                        If objProcessStages(intSysCounter).StageType <> StageTypes.STG_SYSTEM Then
                                            Exit For
                                        End If
                                    Next
                                    intCounter = intSysCounter
                                End If
                                Exit For
                            End If
                        Else
                            If UCase(strSubmitStage) = UCase(drStages("FromStageID").ToString) Then
                                strSubmitter = drStages("UserID").ToString
                                strSubmitionDateTime = drStages("EventTime").ToString
                            End If
                        End If
                    Next

                    If intCounter <= objProcessStages.Length - 1 Then
                        If objProcessStages(intCounter).IsStaticApprovers = True Then
                            If UCase(objProcessStages(intCounter).StageID) = UCase(NextStageID) Then
                                If InStr(strNextApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strNextApprovers = strNextApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            ElseIf UCase(objProcessStages(intCounter).StageID) = UCase(CurrentStageID) Then
                                strStageName = objProcessStages(intCounter).StageName
                                If InStr(strCurrentApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strCurrentApprovers = strCurrentApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            Else
                                If InStr(strApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strApprovers = strApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            End If
                        Else
                            strSQL = objProcessStages(intCounter).ApproversList
                            If strSQL <> "" Then
                                strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                                drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drApprovers.Read
                                    If UCase(objProcessStages(intCounter).StageID) = UCase(NextStageID) Then
                                        strNextApprovers = strNextApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                    ElseIf UCase(objProcessStages(intCounter).StageID) = UCase(CurrentStageID) Then
                                        strStageName = objProcessStages(intCounter).StageName
                                        strCurrentApprovers = strCurrentApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                    Else
                                        strApprovers = strApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                    End If
                                End While
                                drApprovers.Close()
                                CommonFunction.Data.DisposeDataReader(drApprovers)
                            End If
                        End If

                        If objProcessStages(intCounter).IsStaticNotifiables = True Then
                            strNotifiables = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                        Else
                            strSQL = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                            If strSQL <> "" Then
                                strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                                drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strNotifiables = ""
                                While drApprovers.Read
                                    strNotifiables = strNotifiables + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                End While
                                drApprovers.Close()
                                CommonFunction.Data.DisposeDataReader(drApprovers)
                            End If
                        End If
                    End If
                End While
                drStages.Close()
                CommonFunctions.Data.DisposeDataReader(drStages)

                If strApprovers <> "" Then
                    If strApprovers.LastIndexOf(",") = strApprovers.Length - 1 Then
                        strApprovers = strApprovers.Remove(strApprovers.Length - 1, 1)
                    End If
                End If

                If strNextApprovers <> "" Then
                    If strNextApprovers.LastIndexOf(",") = strNextApprovers.Length - 1 Then
                        strNextApprovers = strNextApprovers.Remove(strNextApprovers.Length - 1, 1)
                    End If
                End If

                If strCurrentApprovers <> "" Then
                    If strCurrentApprovers.LastIndexOf(",") = strCurrentApprovers.Length - 1 Then
                        strCurrentApprovers = strCurrentApprovers.Remove(strCurrentApprovers.Length - 1, 1)
                    End If
                End If

                If strNotifiables <> "" Then
                    If strNotifiables.LastIndexOf(",") = strNotifiables.Length - 1 Then
                        strNotifiables = strNotifiables.Remove(strNotifiables.Length - 1, 1)
                    End If
                End If

                GetEmailDetail(objE, "APPROVE")
                objE.MailFrom = objE.MailFrom.Replace("<APPROVERS_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)

                If strApprovers <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailTo = objE.MailTo.Replace("<PREVIOUS_LEVEL_AAPROVER_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailTo = objE.MailTo.Replace("<PREVIOUS_LEVEL_AAPROVER_EMAILID>", "")
                End If

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strSubmitter + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    strSubmitterName = drEmailID("EmployeeName").ToString
                End While
                drEmailID.Close()
                objE.MailTo = objE.MailTo.Replace("<SUBMITTER_EMAILID>", sbEmailID.ToString)

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                If strNextApprovers <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNextApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailCC = objE.MailCC.Replace("<NEXT_LEVEL_APPROVER_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailCC = objE.MailCC.Replace("<NEXT_LEVEL_APPROVER_EMAILID>", "")
                End If

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                If strCurrentApprovers <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strCurrentApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailCC = objE.MailCC.Replace("<CURRENT_APPROVER_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailCC = objE.MailCC.Replace("<CURRENT_APPROVER_EMAILID>", "")
                End If

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                If strNotifiables <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNotifiables + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailCC = objE.MailCC.Replace("<NOTIFY_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailCC = objE.MailCC.Replace("<NOTIFY_EMAILID>", "")
                End If
                CommonFunctions.Data.DisposeDataReader(drEmailID)

                objE.Subject = objE.Subject.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                objE.Body = objE.Body.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                objE.Body = objE.Body.Replace("<APPROVED_DATETIME>", Now.ToString)
                objE.Body = objE.Body.Replace("<CREATED_DATETIME>", strSubmitionDateTime)
                objE.Body = objE.Body.Replace("<APPROVER_NAME>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
                objE.Body = objE.Body.Replace("<SUBMITTER_NAME>", strSubmitterName)
                objE.Body = objE.Body.Replace("<STAGE_NAME>", strStageName)
                ToEmailID = objE.MailTo.TrimStart
                FromEmailID = objE.MailFrom.TrimStart
                CCEmailID = objE.MailCC.TrimStart
                Subject = objE.Subject
                Message = objE.Body
            Catch ex As Exception

            Finally
                objProcessStages = Nothing
                objProcess = Nothing
            End Try

        End Sub

        Public Shared Sub RejectMail(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCEmailID As String, ByRef Subject As String, ByRef Message As String, ByVal InstanceID As String, ByVal ProcessID As String, ByVal NextStageID As String, ByVal CurrentStageID As String, ByVal PrimaryKeyValue As String)
            Dim objProcessStages() As WorkFlowCommonEngine.DefinitionTables.ProcessStage
            Dim objProcess As WorkFlowCommonEngine.DefinitionTables.Process
            Dim intCounter As Integer
            Dim drApprovers As IDataReader
            Dim drEmailID As IDataReader
            Dim drStages As IDataReader
            Dim sbEmailID As New System.Text.StringBuilder
            Dim strApprovers As String
            Dim strNextApprovers As String
            Dim strCurrentApprovers As String
            Dim strSQL As String
            Dim strSubmitStage As String
            Dim objE As New WorkFlowCommonEngine.DefinationStructures.WorkflowEmails
            Dim strSubmitter As String
            Dim strSubmitterName As String
            Dim strSubmitionDateTime As String
            Dim strStageName As String
            Dim strComments As String
            Dim strNotifiables As String
            Dim intSysCounter As Integer

            Try
                objProcess = GetProcessMasterHashTableObject(ProcessID)
                objProcessStages = GetProcessStageHashTableObject(ProcessID)
                strSubmitStage = objProcessStages(0).StageID

                drStages = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_WF_Event '" + InstanceID + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                strApprovers = ""
                strNextApprovers = ""
                strCurrentApprovers = ""
                While drStages.Read
                    For intCounter = 0 To objProcessStages.Length - 1
                        If UCase(strSubmitStage) <> UCase(objProcessStages(intCounter).StageID) Then
                            If UCase(objProcessStages(intCounter).StageID) = UCase(drStages("FromStageID").ToString) Or UCase(objProcessStages(intCounter).StageID) = UCase(NextStageID) Then
                                If objProcessStages(intCounter).StageType = StageTypes.STG_SYSTEM Or objProcessStages(intCounter).StageType = StageTypes.STG_TIME Then
                                    intCounter = intCounter + 1
                                    For intSysCounter = intCounter To objProcessStages.Length - 1
                                        If objProcessStages(intSysCounter).StageType <> StageTypes.STG_SYSTEM Then
                                            Exit For
                                        End If
                                    Next
                                    intCounter = intSysCounter
                                End If
                                Exit For
                            End If
                        Else
                            If UCase(strSubmitStage) = UCase(drStages("FromStageID").ToString) Then
                                strSubmitter = drStages("UserID").ToString
                                strSubmitionDateTime = drStages("EventTime").ToString
                            End If
                        End If
                    Next

                    If intCounter <= objProcessStages.Length - 1 Then
                        If objProcessStages(intCounter).IsStaticApprovers = True Then
                            If UCase(objProcessStages(intCounter).StageID) = UCase(CurrentStageID) Then
                                strStageName = objProcessStages(intCounter).StageName
                                strComments = CommonFunctions.General.CheckIsNothing(drStages("Comments"), "")
                                If InStr(strCurrentApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strCurrentApprovers = strCurrentApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            Else
                                If InStr(strApprovers, objProcessStages(intCounter).ApproversList + ",") = 0 Then
                                    strApprovers = strApprovers + objProcessStages(intCounter).ApproversList + ","
                                End If
                            End If
                        Else
                            strSQL = objProcessStages(intCounter).ApproversList
                            strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                            drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            While drApprovers.Read
                                If UCase(objProcessStages(intCounter).StageID) = UCase(CurrentStageID) Then
                                    strStageName = objProcessStages(intCounter).StageName
                                    strComments = CommonFunctions.General.CheckIsNothing(drStages("Comments"), "")
                                    strCurrentApprovers = strCurrentApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                Else
                                    strApprovers = strApprovers + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                End If
                            End While
                            drApprovers.Close()
                            CommonFunction.Data.DisposeDataReader(drApprovers)
                        End If
                        If objProcessStages(intCounter).IsStaticNotifiables = True Then
                            strNotifiables = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                        Else
                            strSQL = CommonFunctions.General.CheckIsNothing(objProcessStages(intCounter).NotifiablesList, "")
                            If strSQL <> "" Then
                                strSQL = ReplacePlaceHolders(strSQL, PrimaryKeyValue)
                                drApprovers = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strNotifiables = ""
                                While drApprovers.Read
                                    strNotifiables = strNotifiables + CommonFunctions.General.CheckIsNothing(drApprovers(0), "") + ","
                                End While
                                drApprovers.Close()
                                CommonFunction.Data.DisposeDataReader(drApprovers)
                            End If
                        End If
                    End If
                End While
                drStages.Close()
                CommonFunctions.Data.DisposeDataReader(drStages)

                If strApprovers <> "" Then
                    If strApprovers.LastIndexOf(",") = strApprovers.Length - 1 Then
                        strApprovers = strApprovers.Remove(strApprovers.Length - 1, 1)
                    End If
                End If

                If strCurrentApprovers <> "" Then
                    If strCurrentApprovers.LastIndexOf(",") = strCurrentApprovers.Length - 1 Then
                        strCurrentApprovers = strCurrentApprovers.Remove(strCurrentApprovers.Length - 1, 1)
                    End If
                End If

                If strNotifiables <> "" Then
                    If strNotifiables.LastIndexOf(",") = strNotifiables.Length - 1 Then
                        strNotifiables = strNotifiables.Remove(strNotifiables.Length - 1, 1)
                    End If
                End If

                GetEmailDetail(objE, "REJECT")
                objE.MailFrom = objE.MailFrom.Replace("<APPROVERS_EMAILID>", CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString)

                If strApprovers <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailTo = objE.MailTo.Replace("<PREVIOUS_LEVEL_AAPROVER_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailTo = objE.MailTo.Replace("<PREVIOUS_LEVEL_AAPROVER_EMAILID>", "")
                End If

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strSubmitter + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drEmailID.Read
                    sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    strSubmitterName = drEmailID("EmployeeName").ToString
                End While
                drEmailID.Close()
                objE.MailTo = objE.MailTo.Replace("<SUBMITTER_EMAILID>", sbEmailID.ToString)

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                If strCurrentApprovers <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strCurrentApprovers + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailCC = objE.MailCC.Replace("<CURRENT_APPROVER_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailCC = objE.MailCC.Replace("<CURRENT_APPROVER_EMAILID>", "")
                End If

                If sbEmailID.Length >= 1 Then
                    sbEmailID.Remove(0, sbEmailID.Length)
                End If

                If strNotifiables <> "" Then
                    drEmailID = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_EmailID_Workflow '" + strNotifiables + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    While drEmailID.Read
                        sbEmailID.Append(CommonFunctions.Data.CheckIsDBNull(drEmailID(0), "").ToString + ";")
                    End While
                    drEmailID.Close()
                    objE.MailCC = objE.MailCC.Replace("<NOTIFY_EMAILID>", sbEmailID.ToString)
                Else
                    objE.MailCC = objE.MailCC.Replace("<NOTIFY_EMAILID>", "")
                End If
                CommonFunctions.Data.DisposeDataReader(drEmailID)

                objE.Subject = objE.Subject.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                objE.Body = objE.Body.Replace("<WORKFLOW_NAME>", objProcess.ProcessName)
                objE.Body = objE.Body.Replace("<REJECTED_DATETIME>", Now.ToString)
                objE.Body = objE.Body.Replace("<CREATED_DATETIME>", strSubmitionDateTime)
                objE.Body = objE.Body.Replace("<APPROVER_NAME>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
                objE.Body = objE.Body.Replace("<SUBMITTER_NAME>", strSubmitterName)
                objE.Body = objE.Body.Replace("<STAGE_NAME>", strStageName)
                objE.Body = objE.Body.Replace("<REJECTION_REASON>", strComments)
                ToEmailID = objE.MailTo.TrimStart
                FromEmailID = objE.MailFrom.TrimStart
                CCEmailID = objE.MailCC.TrimStart
                Subject = objE.Subject
                Message = objE.Body
            Catch ex As Exception

            Finally
                objProcessStages = Nothing
                objProcess = Nothing
            End Try

        End Sub
        'Added By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1
        Private Shared Sub GetEmailDetail(ByRef Email As WorkFlowCommonEngine.DefinationStructures.WorkflowEmails, ByVal Action As String)
            '=====================================================================
            ' Procedure Name        :	GetEmailDetail
            ' Purpose               :	Get the respective email details
            ' Description           :	Same as above
            ' Parameters Passed     :	Email - WorkFlowCommonEngine.DefinationStructures.WorkflowEmails
            '                           Action - string
            ' Parameters Affected   :	Email.
            ' Assumptions           :	-
            ' Dependencies          :	None.
            ' Author                :	NileshD
            ' Created               :	Dec 09, 2005 
            ' Revisions             :
            '=====================================================================
            Dim drEmail As IDataReader

            If UCase(Action) = "SUBMIT" Then
                drEmail = CommonFunctions.Data.GetDataReader("usp_sel_tbl_UI_EmailMessages_workflow 'SUBMIT'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            ElseIf UCase(Action) = "APPROVE" Then
                drEmail = CommonFunctions.Data.GetDataReader("usp_sel_tbl_UI_EmailMessages_workflow 'APPROVE'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            ElseIf UCase(Action) = "REJECT" Then
                drEmail = CommonFunctions.Data.GetDataReader("usp_sel_tbl_UI_EmailMessages_workflow 'REJECT'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            ElseIf UCase(Action) = "RESUBMIT" Then
                drEmail = CommonFunctions.Data.GetDataReader("usp_sel_tbl_UI_EmailMessages_workflow 'RESUBMIT'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If drEmail.Read Then
                Email.MailFrom = CommonFunctions.General.CheckIsNothing(drEmail("FromEmailID"), "")
                Email.MailTo = CommonFunctions.General.CheckIsNothing(drEmail("ToEmailID"), "")
                Email.MailCC = CommonFunctions.General.CheckIsNothing(drEmail("CCEmailID"), "")
                Email.Subject = CommonFunctions.General.CheckIsNothing(drEmail("Subject"), "")
                Email.Body = CommonFunctions.General.CheckIsNothing(drEmail("Body"), "")
                Email.ShowPopup = CType(CommonFunctions.General.CheckIsNothing(drEmail("ShowPopup"), "0"), Boolean)
            End If
            drEmail.Close()
            CommonFunctions.Data.DisposeDataReader(drEmail)
        End Sub
        'End of Addition By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1

        Private Shared Function ReplacePlaceHolders(ByVal SQL As String, ByVal PrimaryKeyValue As String) As String
            SQL = SQL.Replace("<UNIQUE_ID>", PrimaryKeyValue)
            SQL = SQL.Replace("<USER_ID>", CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0"))
            Return SQL
        End Function
    End Class

End Namespace

