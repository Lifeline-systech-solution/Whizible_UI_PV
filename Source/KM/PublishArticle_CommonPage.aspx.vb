Imports CommonEngines.General.cEventHandlers
Partial Public Class PublishArticle_CommonPage
    Inherits CommonPage
    Public Shared m_intQueryID As String
    Protected m_intProcedureID As String
    Protected intQueryID As String
    Private IsSaveOperation As Boolean = False
    Protected WithEvents objWorkFlowDefinition As WorkFlowGeneral.DefinitionDetails.Definition

    Protected Overrides Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "CommonList.aspx"
        MyBase.strFormPage = "PublishArticle_CommonPage.aspx"
        MyBase.strSubTagFormPage = "../General/CommonSubTag.aspx"


        If Not Request.QueryString("QueryID") Is Nothing OrElse Request.QueryString("QueryID") <> "" Then
            m_intQueryID = Request.QueryString("QueryID")
            intQueryID = Request.QueryString("QueryID")
        End If

        If Not Request.QueryString("ProcedureID") Is Nothing OrElse Request.QueryString("ProcedureID") <> "" Then
            m_intProcedureID = Request.QueryString("ProcedureID")
        End If

        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New PublishArticle_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New PublishArticle_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Args.ToBeInserted = PlotWorkflowLinks(WhizGlobal.TagID, Args.PrimaryKeyValue, WhizGlobal)
    End Sub
    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strScript As New System.Text.StringBuilder
        If Args.ClientSideFunctionName.ToUpper.ToString = "SAVE_ONCLICK" Then
            Dim intDisplaySaveLink As Integer
            Dim strSQL As String = "usp_get_Workflow_SaveLinkAccess "
            Dim strUniqueID As String = ""
            If Args.PrimaryKeyValue = "" Then
                strUniqueID = "0"
            Else
                strUniqueID = Args.PrimaryKeyValue
            End If

            strSQL = strSQL + strUniqueID.ToString
            strSQL = strSQL + "," + WhizGlobal.TagID.ToString
            strSQL = strSQL + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString
            strSQL = strSQL + ",-1"
            strSQL = strSQL + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), "0").ToString

            intDisplaySaveLink = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, 2), 2)

            If intDisplaySaveLink = 0 Then
                Cancel = True
            ElseIf intDisplaySaveLink = 1 Then
                Cancel = False
            End If

            'strScript.Append("<script language='javascript'>" + vbCrLf)
            ''/DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035
            'strScript.Append("var strParentPage;" + vbCrLf)
            'strScript.Append("strParentPage = '../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035';" + vbCrLf)
            'strScript.Append("refreshParent('frmDM_WorkFlowApprovals', 'DM_WorkFlowApprovals.aspx',strParentPage);" + vbCrLf)
            'strScript.Append("window.close();" + vbCrLf)
            'strScript.Append("</script>" + vbCrLf)
            'CommonFunction.General.WriteHTML(strScript.ToString)

        End If

        If Args.ClientSideFunctionName.ToUpper.ToString = "BACK_ONCLICK" Then
            If Not Request.QueryString("FromWorkFlow") Is Nothing Or Not Request.QueryString("FromWorkFlow") <> "" Then
                If Request.QueryString("FromWorkFlow") = "1" Then
                    Cancel = True
                End If
            End If
        End If

    End Sub
    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        PerformWorkflowAction(m_objGlobal.TagID, strPrimaryKey, m_objGlobal)
    End Function
    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        'If Not Request.QueryString("Operation") Is Nothing OrElse Request.QueryString("Operation") <> "" Then
        '    If Request.QueryString("Operation").ToUpper = "SAVE" Then
        '        PageUIPostRender = "strParentPage = new String();" + vbCrLf
        '        PageUIPostRender += " if (window.opener != null) " + vbCrLf
        '        PageUIPostRender += "{" + vbCrLf
        '        'PageUIPostRender += "var objStatusID = window.opener.document.getElementById('StatusID');" + vbCrLf
        '        'PageUIPostRender += "var objFunctionId = window.opener.document.getElementById('FunctionId');" + vbCrLf
        '        'PageUIPostRender += "var objTargetLocationId = window.opener.document.getElementById('TargetLocationId');" + vbCrLf
        '        'PageUIPostRender += "var objRequestTypeID = window.opener.document.getElementById('RequestTypeID');" + vbCrLf
        '        'PageUIPostRender += "var objPriorityID = window.opener.document.getElementById('PriorityID');" + vbCrLf
        '        PageUIPostRender += "strParentPage = '../General/CommonList.aspx?';" + vbCrLf
        '        PageUIPostRender += "strParentPage = strParentPage + 'MasterTagID=20020&From=PublishSave';" + vbCrLf
        '        'PageUIPostRender += "strParentPage = strParentPage + 'StatusID='+objStatusID.value+'&FunctionId='+objFunctionId.value+'&TargetLocationId='+objTargetLocationId.value+'&RequestTypeID='+objRequestTypeID.value+'&PriorityID='+objPriorityID.value;" + vbCrLf
        '        'PageUIPostRender += "objfrm.action='../km/PublishArticle_CommonPage.aspx?MasterTagID=20023&ProcedureID_PK='+<%=m_intProcedureID%>+'&FromWhere=PublishKM&ProcedureID='+<%=m_intProcedureID%>+'&QueryID='+<%=intQueryID%>';" + vbCrLf
        '        'PageUIPostRender += "objfrm.submit();" + vbCrLf
        '        PageUIPostRender += "refreshParent('frmCommonList', 'CommonList.aspx', strParentPage)" + vbCrLf
        '        'PageUIPostRender += "window.close();" + vbCrLf
        '        PageUIPostRender += "}" + vbCrLf
        '        strActionCode = ReturnCodes.ON_LOAD.ToString
        '    End If
        'End If
    End Function
    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strSQL As String

        If PrimaryKey <> "" Then
            strSQL = "usp_ins_tbl_KM_Attachments_Draft " + m_intQueryID.ToString + "," + PrimaryKey + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        End If

        RedirectToCL = False
        strActionCode = ReturnCodes.ON_LOAD.ToString
    End Function
    Private Sub UpdateWhizibleWorkflowData(ByVal m_GlobalObject As WebPages.Template.IGlobal, ByVal PrimaryKeyValue As String, ByVal strAction As String, ByVal strTagID As String, Optional ByVal strWorkflowOption As String = "")

        Dim strActionID As String = ""
        Dim strInstanceID As String = ""
        Dim strPrimaryKey As String = ""
        Dim m_strStageConditionError As String = ""
        Dim strRequestStageID As String = ""
        Dim strProjectNODID As String = ""
        Dim dr As IDataReader
        Dim drStage As IDataReader
        Dim strQuery As String
        Dim strComments As String = ""
        Dim objDS As DataSet
        Dim sb_UWW As New System.Text.StringBuilder
        Dim iMsgID As Integer
        strComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments_hidden"), "").ToString

        dr = CommonFunction.Data.GetDataReader("usp_get_WorkflowDetails " + PrimaryKeyValue + "," + strTagID + ",'" + strAction + "'", True)
        If dr.Read Then
            strPrimaryKey = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("PrimaryKey"), ""), "").ToString
            strActionID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("ActionID"), ""), "").ToString
            strInstanceID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("InstanceID"), ""), "").ToString
            strRequestStageID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("RequestStageID"), ""), "").ToString
            strProjectNODID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("ProjectNatureOfDemandID"), ""), "").ToString
        End If

        CommonFunction.Data.DisposeDataReader(dr)

        objWorkFlowDefinition = New WorkFlowGeneral.DefinitionDetails.Definition
        objWorkFlowDefinition.Initialize()

        objWorkFlowDefinition.m_strConnString = CommonFunctions.General.BuildConnectionString(CommonFunction.General.GetApplicationKeySetting("ConnectionString"))

        objWorkFlowDefinition.FillWorkFlowDefinition(m_GlobalObject, strPrimaryKey)

        m_GlobalObject.TagID = 3929

        If PrimaryKeyValue <> "" Then
            If strAction <> "" Then
                '''<Summary>
                '''Author   :   PrashantSJ
                '''Date     :   10 May 2008
                '''Date     :   To return the Action Type MsgID w.r.t TagID
                '''</Summary>
                sb_UWW.Append("usp_Sel_IM_EmailMessages NULL ")
                sb_UWW.Append("," + strTagID)

                objDS = CommonFunction.Data.GetDataSet(sb_UWW.ToString, "ActionMessage", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                For Each objdataRow As DataRow In objDS.Tables(0).Select("ActionType='" + strAction + "'")
                    iMsgID = CInt(CommonFunction.Data.CheckIsDBNull(objdataRow("MsgID"), "0"))
                Next

                sb_UWW.Remove(0, sb_UWW.Length)

                '''End of addition by PrashantSJ on 10 May 2008

                If strAction = "SYS_SUBMIT" Then
                    m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_GlobalObject, strPrimaryKey, "SUBMIT", strActionID, "")
                    If objWorkFlowDefinition.m_strInstanceID <> "" Then
                        UpdateEvent(UCase(CommonFunction.General.CheckIsNothing(objWorkFlowDefinition.m_strInstanceID, "")), strComments)
                    End If
                ElseIf strAction = "SYS_APPROVE" Then


                    m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_GlobalObject, strPrimaryKey, "APPROVE", strActionID, strInstanceID)
                    If strInstanceID <> "" Then
                        UpdateEvent(UCase(CommonFunction.General.CheckIsNothing(strInstanceID, "")), strComments)
                    End If
                    'End If
                ElseIf strAction = "SYS_REJECT" Then
                    m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_GlobalObject, strPrimaryKey, "REJECT", strActionID, strInstanceID)
                    'If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
                    If strInstanceID <> "" Then
                        UpdateEvent(UCase(CommonFunction.General.CheckIsNothing(strInstanceID, "")), strComments)
                    End If
                    'End If
                End If

                If m_strStageConditionError = "" Then

                    If strTagID = CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING.ToString Then
                        UpdateProjectRevisionDetails(PrimaryKeyValue, strAction, strTagID, strRequestStageID, strProjectNODID, strWorkflowOption)
                    Else
                        UpdateOtherEntityRevisions(PrimaryKeyValue, strAction, strTagID, strRequestStageID, strProjectNODID, strWorkflowOption)
                    End If

                    SendWorkflowEmails(iMsgID, strPrimaryKey)

                    '''To refresh Workflow Approval page after specified action
                    sb_UWW.Append("<script language='javascript'>" & vbCrLf)
                    sb_UWW.Append("if (window.opener!=null )" & vbCrLf)
                    sb_UWW.Append("{" & vbCrLf)
                    sb_UWW.Append("refreshParent('frmDM_WorkFlowApprovals','DM_WorkFlowApprovals.aspx','../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035',true);" & vbCrLf)
                    sb_UWW.Append("}" & vbCrLf)
                    sb_UWW.Append("</script>" & vbCrLf)
                    CommonFunction.General.WriteHTML(sb_UWW.ToString)

                End If

                drStage = CommonFunction.Data.GetDataReader("SELECT RequestStageID FROM tbl_IM_WorkflowInstance WHERE WorkflowInstanceID=" + strPrimaryKey, MyBase.UseSQL)
                If drStage.Read Then
                    If (drStage("RequestStageID").ToString) = "3" Then
                        strQuery = "EXEC usp_ins_tbl_KM_CodeHeadings_FromDraft "
                        strQuery = strQuery + "" & PrimaryKeyValue.ToString & ""
                        CommonFunctions.Data.InsertOrUpdateData(strQuery.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drStage)
            End If

        End If

        objDS = Nothing
        sb_UWW = Nothing
        objWorkFlowDefinition = Nothing
        m_GlobalObject.TagID = strTagID.ToString
    End Sub
    Private Sub SendWorkflowEmails(ByVal MsgID As Integer, ByVal PrimaryKeyValue As String)
        Dim drEmailMessage As IDataReader
        Dim blnSendEMail As Boolean
        Dim blnShowPopUp As Boolean
        Dim sbEM As New System.Text.StringBuilder
        Dim strComments As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments_hidden"), "").ToString


        strComments = HttpContext.Current.Server.UrlEncode(strComments)

        ' Retrieve the details of the message to be sent to the Resource.
        sbEM.Append("usp_Sel_IM_EmailMessages " & MsgID)

        drEmailMessage = CommonFunction.Data.GetDataReader(sbEM.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drEmailMessage.Read Then
            blnSendEMail = CType(drEmailMessage("SendMail"), Boolean)
            blnShowPopUp = CType(drEmailMessage("ShowPopup"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drEmailMessage)
        sbEM.Remove(0, sbEM.Length)

        If blnSendEMail = True Then
            ' Check if a popup message has to be shown.
            If blnShowPopUp = True Then
                sbEM.Append("<Script language=javascript>")
                sbEM.Append("window.open('../General/SendEmail.aspx?MessageID=" + MsgID.ToString + "&workflow=1&PrimaryKeyValue=" + PrimaryKeyValue.ToString + "&Comments=" + strComments.Replace("'", "\'") + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                sbEM.Append("</Script>")
                CommonFunction.General.WriteHTML(sbEM.ToString)
                ' Else, if the mail has to be sent silently, then...
                'Else

                '    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_34(strFromEmailID, strToEmailID, strCCToEmailId, strSubject, strEmailMsg, lngIssueID, "DT") 'ie Mail fires from DT

                '    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailId, strFromEmailID, strSubject, strEmailMsg)
            End If
        End If
        sbEM = Nothing

    End Sub

    Private Sub UpdateOtherEntityRevisions(ByVal PrimaryKeyValue As String, ByVal WorkflowAction As String, ByVal TagID As String, ByVal RequestStageID As String, ByVal ProjectNatureOfDemandID As String, ByVal strWorkflowOption As String)

        Dim strSQLQuery As New System.Text.StringBuilder
        Dim intRevisionReasonID As Integer = 0
        Dim strRevisionRequestStageID As String = ""
        Dim strNextStageID As String = ""
        Dim ds As DataSet

        Dim strSQL As String
        Dim strURL As String
        Dim drfuncAttachments As IDataReader
        Dim strSourceFilePath As String
        Dim strDestinationFileName As String
        Dim strAttachmentType As String
        strAttachmentType = "File"

        strSQLQuery.Append("usp_Sel_WorkflowsStages  -1" + vbCrLf)
        'strSQLQuery.Append(HttpContext.Current.Session("intProjectID").ToString + vbCrLf)
        strSQLQuery.Append("," & TagID)
        strSQLQuery.Append("," & PrimaryKeyValue + vbCrLf)

        ds = CommonFunction.Data.GetDataSet(strSQLQuery.ToString, "Revision", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        For Each objdataRow As DataRow In ds.Tables(0).Select("ProjectNatureOfDemandID=" + ProjectNatureOfDemandID)
            strRevisionRequestStageID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdataRow("RevisionRequestStageID"), ""), "").ToString
            strNextStageID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdataRow("NextStageID"), ""), "").ToString
        Next

        ds = Nothing
        strSQLQuery.Remove(0, strSQLQuery.Length)

        Select Case WorkflowAction.ToUpper.Trim
            Case "SYS_SUBMIT"
                strSQLQuery.Append("EXEC usp_Upd_EntityRevision_BaselineStatus " + vbCrLf)
                strSQLQuery.Append("N'" & PrimaryKeyValue & "'" + vbCrLf)
                strSQLQuery.Append("," & TagID + vbCrLf)
                strSQLQuery.Append(",N'S'")
                strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'" + vbCrLf)


            Case "SYS_APPROVE"

                'If (strRevisionRequestStageID = RequestStageID And strNextStageID <> RequestStageID) Or (strWorkflowOption = "JUMPTOSTAGE") Then
                '    strSQLQuery.Append("EXEC usp_Upd_EntityRevision_BaselineStatus " + vbCrLf)
                '    strSQLQuery.Append("N'" & PrimaryKeyValue & "'" + vbCrLf)
                '    strSQLQuery.Append("," & TagID + vbCrLf)
                '    strSQLQuery.Append(",N'B'")
                '    strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'" + vbCrLf)
                'End If
                strSQL = "SELECT Attachments,OriginalFileName FROM tbl_KM_Attachments_Draft WHERE ProcedureID= " + PrimaryKeyValue.ToString
                drfuncAttachments = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                While drfuncAttachments.Read
                    strSourceFilePath = "..\..\Attachments\CRM\" + CommonFunctions.Data.CheckIsDBNull(drfuncAttachments("Attachments")).ToString
                    strSourceFilePath = HttpContext.Current.Server.MapPath(strSourceFilePath)

                    strDestinationFileName = "..\..\Attachments\KM\" + CommonFunctions.Data.CheckIsDBNull(drfuncAttachments("Attachments")).ToString
                    strDestinationFileName = HttpContext.Current.Server.MapPath(strDestinationFileName)

                    If (CommonFunctions.FileDirectory.IsFileExists(strSourceFilePath)) Then
                        CommonFunctions.FileDirectory.CopyFile(strSourceFilePath, strDestinationFileName, True)
                    End If
                End While

                If strRevisionRequestStageID = RequestStageID And strNextStageID = "" Then
                    strSQLQuery.Append("EXEC usp_ins_tbl_KM_CodeHeadings_FromDraft " + vbCrLf)
                    strSQLQuery.Append("" & PrimaryKeyValue.ToString & "" + vbCrLf)
                End If

            Case "SYS_REJECT"
                If strRevisionRequestStageID = RequestStageID And strNextStageID <> RequestStageID Then
                    strSQLQuery.Append("EXEC usp_Upd_EntityRevision_BaselineStatus " + vbCrLf)
                    strSQLQuery.Append("N'" & PrimaryKeyValue & "'" + vbCrLf)
                    strSQLQuery.Append("," & TagID + vbCrLf)
                    strSQLQuery.Append(",N'R'")
                    strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'" + vbCrLf)
                End If
        End Select

        If strSQLQuery.ToString <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        End If

        strSQLQuery = Nothing
        CommonFunction.Data.DisposeDataReader(drfuncAttachments)
    End Sub
    Private Sub UpdateProjectRevisionDetails(ByVal PrimaryKeyValue As String, ByVal WorkflowAction As String, ByVal TagID As String, ByVal RequestStageID As String, ByVal ProjectNatureOfDemandID As String, ByVal strWorkflowOption As String)
        Dim strSQLQuery As New System.Text.StringBuilder
        Dim intRevisionReasonID As Integer = 0
        Dim strRevisionRequestStageID As String = ""
        Dim strNextStageID As String = ""
        Dim ds As DataSet

        strSQLQuery.Append("usp_Sel_WorkflowsStages " + vbCrLf)
        strSQLQuery.Append(PrimaryKeyValue + vbCrLf)
        strSQLQuery.Append("," & TagID)
        strSQLQuery.Append("," & PrimaryKeyValue + vbCrLf)

        ds = CommonFunction.Data.GetDataSet(strSQLQuery.ToString, "Revision", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        For Each objdataRow As DataRow In ds.Tables(0).Select("ProjectNatureOfDemandID=" + ProjectNatureOfDemandID)
            strRevisionRequestStageID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdataRow("RevisionRequestStageID"), ""), "").ToString
            strNextStageID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdataRow("NextStageID"), ""), "").ToString
        Next

        ds = Nothing
        strSQLQuery.Remove(0, strSQLQuery.Length)

        Select Case WorkflowAction.ToUpper.Trim
            Case "SYS_SUBMIT"
                strSQLQuery.Append("EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason " + vbCrLf)
                strSQLQuery.Append("N'" & PrimaryKeyValue & "'" + vbCrLf)
                strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments_hidden"), "").ToString()) & "'" + vbCrLf)
                strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'" + vbCrLf)
                strSQLQuery.Append(",N'S'")

                intRevisionReasonID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                strSQLQuery.Remove(0, strSQLQuery.Length)

                If intRevisionReasonID > 0 Then
                    strSQLQuery.Append("EXEC usp_Upd_tbl_PM_ProjectRevision_BaselineStatus " + vbCrLf)
                    strSQLQuery.Append(PrimaryKeyValue + vbCrLf)
                    strSQLQuery.Append(", N'S'")

                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    strSQLQuery.Remove(0, strSQLQuery.Length)

                    'Update the field SentForApprovalBy field value with the logged in user's name
                    strSQLQuery.Append("EXEC usp_Upd_tbl_PM_ProjectRevision_SentForApprovalBy " + vbCrLf)
                    strSQLQuery.Append(PrimaryKeyValue + vbCrLf)
                    strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'" + vbCrLf)

                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strSQLQuery.Remove(0, strSQLQuery.Length)
                End If
            Case "SYS_APPROVE"

                If (strRevisionRequestStageID = RequestStageID And strNextStageID <> RequestStageID) Or (strWorkflowOption = "JUMPTOSTAGE") Then
                    strSQLQuery.Append("EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason " + vbCrLf)
                    strSQLQuery.Append("N'" & PrimaryKeyValue & "'" + vbCrLf)
                    strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments_hidden"), "").ToString()) & "'" + vbCrLf)
                    strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'" + vbCrLf)
                    strSQLQuery.Append(",N'A' ")

                    intRevisionReasonID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                    strSQLQuery.Remove(0, strSQLQuery.Length)

                End If

            Case "SYS_REJECT"
                If strRevisionRequestStageID = RequestStageID And strNextStageID <> RequestStageID Then
                    strSQLQuery.Append("EXEC usp_Ins_tbl_PM_ProjectBaselineRejectionReason " + vbCrLf)
                    strSQLQuery.Append("N'" & PrimaryKeyValue & "'" + vbCrLf)
                    strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments_hidden"), "").ToString()) & "'" + vbCrLf)
                    strSQLQuery.Append(",N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'" + vbCrLf)

                    intRevisionReasonID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                    strSQLQuery.Remove(0, strSQLQuery.Length)
                End If
        End Select

        strSQLQuery = Nothing

    End Sub
    Private Sub UpdateEvent(ByVal InstanceID As String, ByVal Comments As String)
        Dim strSQL As String
        strSQL = "usp_upd_tbl_WF_Event '" + InstanceID + "', N'" + CommonFunction.General.BuildQueryString(Comments) + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) 'Added By UmeshJ 30.06.2007
    End Sub
    Private Sub PerformWorkflowAction(ByVal lngTagID As Long, ByVal strPrimaryKey As String, ByVal m_objGlobalObject As WebPages.Template.IGlobal)
        Dim sbScript As New System.Text.StringBuilder
        Dim strWorkflowoption As String = "SYS_SUBMIT"
        Dim strPrimaryKeyvalue As String
        Dim strValue As String = ""
        Dim SQL As String = "usp_get_WorkflowLinkAccess "
        Dim drAttributeDetails As IDataReader
        Dim strPrimaryKeyName As String = ""
        Dim strtablename As String = ""
        Dim strPageName = ""
        Dim strLinkName As String = ""
        Dim strComments As String = ""
        Dim strHoldComments As String = ""
        Dim strBlockDAComments As String = ""
        Dim strIsApproverSelected As String = ""
        Dim strNewStageID As String = ""
        Dim strJumpToStageComments As String = ""
        Dim strFromWhere As String

        If Not Request.QueryString("strFromWhere") Is Nothing OrElse Request.QueryString("strFromWhere") <> "" Then
            strFromWhere = Request.QueryString("strFromWhere")
        End If

        If strPrimaryKey <> "" Then
            SQL += strPrimaryKey.ToString
            SQL += "," + lngTagID.ToString
            SQL += "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), 0).ToString
            If strFromWhere = "CRM" Then
                SQL += ",-1"
            End If
            SQL += "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0).ToString

            'strLinks = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "")

            drAttributeDetails = CommonFunction.Data.GetDataReader(SQL, True)

            If drAttributeDetails.Read Then
                strPrimaryKeyName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAttributeDetails("PrimaryKeyName"), ""), "").ToString
                strtablename = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAttributeDetails("tablename"), ""), "").ToString
                strPageName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAttributeDetails("PageName"), ""), "").ToString
                strLinkName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAttributeDetails("LinkName"), ""), "").ToString
            End If
        End If

        strValue = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txthidden_NOIID"), "0")

        strComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments_hidden"), "")
        strComments = HttpContext.Current.Server.UrlEncode(strComments)
        'strHoldComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHoldComments_hidden"), "")
        'strBlockDAComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtBlockDAComments_hidden"), "")
        strWorkflowoption = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WorkflowAction"), "").ToString
        strNewStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtNewStageID_hidden"), "")
        'strJumpToStageComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtJumpToStageComments_hidden"), "")

        '--------- Perform workflow action
        '--------- save data in workflow tables
        If strWorkflowoption <> "" Then
            If strPrimaryKey <> "" Then
                strPrimaryKeyvalue = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_ins_UPD_tbl_IM_WorkflowInstance " + strPrimaryKey.ToString + "," + lngTagID.ToString + ",-1," + strValue.ToString + ",'" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString + "'", True), "")
                UpdateWhizibleWorkflowData(m_objGlobalObject, strPrimaryKey, strWorkflowoption, lngTagID.ToString)
            End If
        End If


        If strtablename <> "" Then
            '-------- Approve Reject Comments Div
            'Commented And Added By Chakshuta H on 23rd-Oct-2015 Purpose::Issue Fixing
            'sbScript.Append(vbCrLf + "<DIV id=""DivComments"" style=""WIDTH: 10px;height:150px;DISPLAY:none;OVERFLOW:hidden;border:black 1px outset;"">" + vbCrLf)
            sbScript.Append(vbCrLf + "<DIV id=""DivComments"" style=""WIDTH: 10px;height:150px;DISPLAY:none;OVERFLOW:hidden;background-color: #E7F1FE;border:black 1px outset;"">" + vbCrLf)
            'End Of Commented And Added By Chakshuta H on 23rd-Oct-2015 Purpose::Issue Fixing
            sbScript.Append("</DIV>")
            sbScript.Append("<input Type=hidden id='txthidden_NOIID' name='txthidden_NOIID' value =" + strValue.ToString + ">")
            sbScript.Append("<input Type=hidden id='txtComments_hidden' name='txtComments_hidden' value ='" + strComments.ToString + "'>")
            sbScript.Append("<input Type=hidden id='txtHoldComments_hidden' name='txtHoldComments_hidden' value ='" + strHoldComments.ToString + "'>")
            sbScript.Append("<input Type=hidden id='txtBlockDAComments_hidden' name='txtBlockDAComments_hidden' value ='" + strBlockDAComments.ToString + "'>")
            sbScript.Append("<input Type=hidden id='txtNewStageID_hidden' name='txtNewStageID_hidden' value ='" + strNewStageID.ToString + "'>")
            'sbScript.Append("<input Type=hidden id='txtJumpToStageComments_hidden' name='txtJumpToStageComments_hidden' value ='" + strJumpToStageComments.ToString + "'>")


            '-------- Submit - Workflow selection DIV
            sbScript.Append(vbCrLf + "<DIV id=""DivNOI"" style=""WIDTH: 10px;height:150px;DISPLAY:none;OVERFLOW:hidden;border:black 1px outset;"">" + vbCrLf)

            If strPrimaryKey <> "" Then
                sbScript.Append("<Table class=clsTable cellspacing=0 cellpadding=0 style=""height=99.99%;""><TR class=clsTREven><td><b>Select Workflow</b></td></TR><TR class=clsTREven><TD>")
                sbScript.Append(CommonFunction.HTMLControls.DrawComboBox("cboNOI", "usp_sel_ProjectWorkflows  -1," + lngTagID.ToString, 300, , , , True) + "</TD></TR>")
                sbScript.Append("<TR class=clsTREven><TD><Textarea wrap=Hard  name=txtSubmitComments id=txtSubmitComments maxlength=1000  class='clsTextArea' style=""width:300px; height:70px; text-align:Left""; rows=5; cols =20>" + strComments.ToString + "</TextArea><br><img src='../../images/star.gif'></TD></TR>")
                'sbScript.Append("<TR class=clsTREven><TD valign=top><img src='../../images/star.gif'></TD></TR>")
                sbScript.Append("<TR class=clsTREven><TD><input type=button id= btnOK name= btnOK Value = ""   OK   "" style =""font size=9 width=10pts"" onClick = SubmitOK_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "','Edit')> <input type=button id= btnCancel name= btnCancel style =""font size=9"" Value = CANCEL onClick = Cancel_OnClick()>" + vbCrLf) 'CancelNOI_OnClick
                sbScript.Append("</td></tr></table>")
            End If

            sbScript.Append("</DIV>")


            sbScript.Append(CommonFunction.HTMLControls.DrawComboBox("cboNOIApprovers", "usp_sel_IsApproverConfigured_forSubmission  -1," + lngTagID.ToString + "," + HttpContext.Current.Session("intUserID").ToString, 300, , , , True, , , , True) + "</TD></TR>")

            CommonFunction.General.WriteHTML(sbScript.ToString)

        End If

        CommonFunction.Data.DisposeDataReader(drAttributeDetails)

    End Sub

    Private Function PlotWorkflowLinks(ByVal lngTagID As Long, ByVal strPrimaryKey As String, ByVal m_objGlobalObject As WebPages.Template.IGlobal) As String
        '------- For plotting Approve, Reject Submit Links for cofigurable workflows defined
        Dim strLinks As String = ""
        Dim strSQL As String = "usp_get_WorkflowLinkAccess "
        Dim sbScript As New System.Text.StringBuilder
        Dim drAttributeDetails As IDataReader
        Dim strPrimaryKeyName As String = ""
        Dim strtablename As String = ""
        Dim strPageName = ""
        Dim strLinkName As String = ""
        Dim strIsApproverConfigured As String = ""
        Dim strRequestStage As String = ""
        Dim iIsDocumentUploaded As Integer = 0
        Dim dr As IDataReader
        Dim strFromWhere As String

        If Not Request.QueryString("strFromWhere") Is Nothing OrElse Request.QueryString("strFromWhere") <> "" Then
            strFromWhere = Request.QueryString("strFromWhere")
        End If

        If strPrimaryKey.ToString <> "" Then
            strSQL += strPrimaryKey.ToString
            strSQL += "," + lngTagID.ToString
            strSQL += "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), 0).ToString
            If strFromWhere = "CRM" Then
                strSQL += ",-1"
            End If
            strSQL += "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0).ToString

            'strLinks = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "")

            drAttributeDetails = CommonFunction.Data.GetDataReader(strSQL, True)

            If drAttributeDetails.Read Then
                strPrimaryKeyName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAttributeDetails("PrimaryKeyName"), ""), "").ToString
                strtablename = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAttributeDetails("tablename"), ""), "").ToString
                strPageName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAttributeDetails("PageName"), ""), "").ToString
                strLinkName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drAttributeDetails("LinkName"), ""), "").ToString
            End If
            CommonFunction.Data.DisposeDataReader(drAttributeDetails)

            HttpContext.Current.Session("WorkflowLinks") = strLinkName

            Select Case strLinkName
                Case "APPROVE"
                    strSQL = "usp_sel_IsApproverConfigured_forStage "
                    strSQL += strPrimaryKey.ToString
                    strSQL += "," + lngTagID.ToString
                    strSQL += ",'A'"
                    strSQL += "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), 0).ToString

                    dr = CommonFunction.Data.GetDataReader(strSQL, True)
                    While dr.Read()
                        strIsApproverConfigured = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("IsAppSelected"), "1"), "1")
                        strRequestStage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("Stage"), "1"), "1")
                        iIsDocumentUploaded = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("IsDocumentUploaded"), "0"), "0")
                    End While
                    CommonFunction.Data.DisposeDataReader(dr)

                    dr = Nothing

                    'strIsApproverConfigured = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "1"), "1")
                    'strRequestStage()

                    sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Approve_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "'," + strIsApproverConfigured.ToString + ",'" + strRequestStage.ToString + "')"" Title=""Approve"" >Approve</A> ")
                    'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                    ''sbScript.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidIDU", "txtHidIDU", , , , iIsDocumentUploaded.ToString, , , , , , True, , True))
                    sbScript.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidIDU", "txtHidIDU", , , , iIsDocumentUploaded.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                    'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


                    strSQL = "usp_sel_IsApproverConfigured_forStage "
                    strSQL += strPrimaryKey.ToString
                    strSQL += "," + lngTagID.ToString
                    strSQL += ",'R'"
                    strSQL += "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), 0).ToString

                    strIsApproverConfigured = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "1"), "1")

                    dr = CommonFunction.Data.GetDataReader(strSQL, True)
                    While dr.Read()
                        strIsApproverConfigured = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("IsAppSelected"), "1"), "1")
                        strRequestStage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("Stage"), "1"), "1")
                    End While
                    CommonFunction.Data.DisposeDataReader(dr)

                    sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Reject_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "'," + strIsApproverConfigured.ToString + ",'" + strRequestStage.ToString + "')"" Title=""Reject"" >Reject</A> ")
                    '--- force push
                    'sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:ForcePush_OnClick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "')"" Title=""Force Push"" >Force Push</A> ")
                    ''---- Jump TO stage
                    'sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:JumpTo_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "')"" Title=""Jump To Stage"" >Jump To Stage</A> ")
                    ''---- Change Workflow
                    'sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:ChangeWorkflow_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "')"" Title=""Change Workflow"" >Change Workflow</A> ")

                Case "SUBMIT"
                    If strPrimaryKey = "" Then
                        sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Submit_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "','ADD_NEW')"" Title=""Submit"" >Submit</A> ")
                    Else
                        sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Submit_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "','Edit')"" Title=""Submit"" >Submit</A> ")
                    End If
            End Select
        End If


        CommonFunction.Data.DisposeDataReader(drAttributeDetails)
        CommonFunction.Data.DisposeDataReader(dr)

        PlotWorkflowLinks = sbScript.ToString

    End Function
End Class
Public Class PublishArticle_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetUIPageWhereClause(ByVal objGlobal As WebPages.Template.IGlobal, ByVal TableName As String, ByVal PrimaryKey As String, Optional ByRef PrimaryKeyValue As String = "") As String
        GetUIPageWhereClause &= " WHERE 1=1 AND QueryID = " + PublishArticle_CommonPage.m_intQueryID
    End Function
End Class
Public Class PublishArticle_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim strSQL As String
        Dim drArticleProcedureCode As IDataReader
        Dim strIsPresent As String
        Dim sbHtml As System.Text.StringBuilder = New System.Text.StringBuilder

        If Args.ControlName = "ProcedureCode" Then
            If Args.PrimaryKeyValue <> "" Then
                strSQL = "SELECT 1 FROM tbl_KM_CodeHeadings_Draft WHERE ProcedureID=" + Args.PrimaryKeyValue
                strIsPresent = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), "0")
            Else
                strIsPresent = "0"
            End If

            If strIsPresent = "1" Then
                strSQL = "SELECT ProcedureCode FROM tbl_KM_CodeHeadings_Draft WHERE ProcedureID=" + Args.PrimaryKeyValue
                drArticleProcedureCode = CommonFunction.Data.GetDataReader(strSQL, True)
                If drArticleProcedureCode.Read Then
                    sbHtml.Append(drArticleProcedureCode("ProcedureCode").ToString)
                End If
                CommonFunction.Data.DisposeDataReader(drArticleProcedureCode)
            Else
                strSQL = "SELECT CustomerID,SubmittedDate,Description,Subject,Comments FROM tbl_CRM_Query_Master WHERE QueryID = " + PublishArticle_CommonPage.m_intQueryID
                drArticleProcedureCode = CommonFunction.Data.GetDataReader(strSQL, True)

                If drArticleProcedureCode.Read Then
                    sbHtml.Append("Subject : ")
                    sbHtml.Append(drArticleProcedureCode("Subject").ToString)
                    sbHtml.Append("<BR>")
                    sbHtml.Append("Description : ")
                    sbHtml.Append(drArticleProcedureCode("Description").ToString)
                    sbHtml.Append("<BR>")
                    sbHtml.Append("Comments : ")
                    sbHtml.Append(drArticleProcedureCode("Comments").ToString)
                    sbHtml.Append("<BR>")
                    sbHtml.Append("Submitter : ")
                    sbHtml.Append(drArticleProcedureCode("CustomerID").ToString)
                    sbHtml.Append("<BR>")
                    sbHtml.Append("Date : ")
                    sbHtml.Append(drArticleProcedureCode("SubmittedDate").ToString)
                    sbHtml.Append("<BR>")
                End If
                CommonFunction.Data.DisposeDataReader(drArticleProcedureCode)
            End If

            Args.IgnoreActualValue = True
            Args.NewValue = sbHtml.ToString

        End If
    End Sub
End Class

