Imports Whizible
Public Class OverallScheduleCombination
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Protected strSQL As New System.Text.StringBuilder
    Protected intProjectID As String = ""
    Protected intProcessgroupID As String = ""
    Protected strOSCombination As String = ""
    Protected strMandatory As String
    Protected strValidate As String
    Protected strExists As String
    Protected intReleaseID As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        ' DrawPage()
    End Sub

    Public Sub DrawPage()
        Dim i As Integer


        Dim strCmbSQL, strResult As String
        Dim strMode, strSubProject, strModule, strIteration, strIncreament, strPhase, strMilestone, strDeliverable, strIncrement, strRelease, IsAgile As String
        Dim intSubprojectID, intModule, intPhase, intMilestone, intDeliverable As String
        Dim strCreatedBy As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""))
        Dim strTagID, strOperation As String

        Dim strMessage As String = ""

        intProjectID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))
        intProcessgroupID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProcessGroupID"), "0"))
        intReleaseID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ReleaseID"), "0"))
        strMode = Convert.ToString(CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")))
        strTagID = Convert.ToString(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID")))
        strOperation = Convert.ToString(CommonFunctions.General.CheckIsNothing(Request.QueryString("Operation")))
        'strMandatory = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_WPBN_ID_sel_IsIterativeDevelopment_OSCombination " + intProcessgroupID, True), "0"))
        IsAgile = CStr(CommonFunctions.Data.GetDataScalar("usp_sel_Is_AgileProject " + intProjectID + "", True))

        strOSCombination = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_WPBN_OSCombination_List " + intProjectID + "," + intProcessgroupID, True), "0"))
        Dim arrOSCombination() As String = strOSCombination.Split(CChar(","))

        'If strOperation = "DELETE" And strTagID = 20176 Then
        '    DeleteDetails()
        'End If
        If strMode.ToUpper = "SAVE" Or strMode.ToUpper = "SAVEADD" Then
            'strSubProject = CommonFunctions.General.CheckIsNothing(Request.Form("SubProject"))
            strSubProject = CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProject"))
            If strSubProject = "" Then
                strSubProject = "NULL"
            End If
            'strModule = CommonFunctions.General.CheckIsNothing(Request.Form("Module"))
            strModule = CommonFunctions.General.CheckIsNothing(Request.QueryString("Module"))
            If strModule = "" Then
                strModule = "NULL"
            End If
            strIteration = CommonFunctions.General.CheckIsNothing(Request.QueryString("Iteration"))
            If strIteration = "" Then
                strIteration = "NULL"
            End If
            strIncreament = CommonFunctions.General.CheckIsNothing(Request.QueryString("Increament"))
            If strIncreament = "" Then
                strIncreament = "NULL"
            End If
            'strPhase = CommonFunctions.General.CheckIsNothing(Request.Form("Phase"))
            strPhase = CommonFunctions.General.CheckIsNothing(Request.QueryString("Phase"))
            If strPhase = "" Then
                strPhase = "NULL"
            End If
            strMilestone = CommonFunctions.General.CheckIsNothing(Request.QueryString("Milestone"))
            If strMilestone = "" Then
                strMilestone = "NULL"
            End If

            strDeliverable = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectDeliverable"))
            If strDeliverable = "" Then
                strDeliverable = "NULL"
            End If

            strIncrement = CommonFunctions.General.CheckIsNothing(Request.QueryString("Increment"))
            If strIncrement = "" Then
                strIncrement = "NULL"
            End If


            strRelease = CommonFunctions.General.CheckIsNothing(Request.QueryString("Release"))
            If strRelease = "" Then
                strRelease = "NULL"
            End If
            'Chakshuta

            'strValidate = CStr(CommonFunctions.Data.GetDataScalar("usp_validate_CombinationExists " + intProjectID + "," + strSubProject + "," + strModule + "," + strPhase + "," + strMilestone + "," + strDeliverable + "", True))
            strValidate = CStr(CommonFunctions.Data.GetDataScalar("usp_validate_CombinationExists " + intProjectID + "," + strSubProject + "," + strModule + "," + strPhase + "," + strMilestone + "," + strDeliverable + "," + strIncrement + "," + strRelease + "", True))
            'If strValidate = "1" Then
            '    strMessage = "<script language=javascript>"
            '    strMessage = strMessage + "alert('Combination Already present');"
            '    strMessage = strMessage + "</script>"
            '    'Response.Write(strMessage)
            'Else

            'Chakshuta
            'strExists = CStr(CommonFunctions.Data.GetDataScalar("Usp_Validate_AttributeConfiguration " + intProjectID + "", True))
            'If strExists = "1" Then
            '    CommonFunctions.Data.InsertOrUpdateData("usp_Ins_RBM_OverallSchedule_Settings " + intProjectID + "," + intProcessgroupID + "", True)
            'End If

            strResult = CStr(CommonFunctions.Data.GetDataScalar("usp_ins_tbl_WPBN_PM_OverallSchedule_OSCombination " + intProjectID + "," + intProcessgroupID + "," + strSubProject + "," + strModule + "," + strIncrement + "," + strIncreament + "," + strPhase + ",'" + strCreatedBy + "'," + strMilestone + "," + strDeliverable + "," + strRelease + "", True))

            Response.Clear()
            'End If
            Response.Write(strResult.ToString)
            'If strResult.ToString.Trim <> "" Then
            '    CommonFunctions.Data.InsertOrUpdateData(strResult.ToString, MyBase.UseSQL)
            'End If
            Response.End()
        ElseIf strMode.ToUpper = "DELETE" Then
            DeleteDetails()
        Else
            'strSQL.Append(CommonFunctions.General.PlotPageHeadTag("Overall Schedule Combination"))
            strSQL.Append(CommonFunctions.General.PlotPageHeadTag("WBS Combination"))
            strSQL.Append(GenerateMenu())
            strSQL.Append(GeneratePageCaption())
            strSQL.Append("<BR>")
            'Chakshuta
            'strSQL.Append(PlotNote())
            'Chakshuta
            strSQL.Append("<BR>")
            strSQL.Append("<DIV Id=divPage Style='HEIGHT:270px;overflow:auto;WIDTH:100%'>")
            strSQL.Append("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
            If IsAgile = "1" Then
                If intReleaseID = "0" Then
                    For i = 0 To arrOSCombination.Length - 1
                        strSQL.Append("<TR class=clsTRPageHeader><TD align=Right Width='30%'> " + Convert.ToString(arrOSCombination(i).Replace("Iteration", "Iteration/Release")) + "</td><td align=Left Width='70%'>&nbsp; ")

                        If arrOSCombination(i).ToString = "Sub Project" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_SubProject_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Module" Then
                            'strCmbSQL = "usp_Sel_tbl_PM_Module " + intProjectID + ", NULL, 'A'"
                            strCmbSQL = "usp_Sel_tbl_PM_Module_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Phase" Then
                            'strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intProcessgroupID
                            strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Milestone" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_Milestone_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Project Deliverable" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_Deliverables_OSCombination " + intProjectID

                        ElseIf arrOSCombination(i).ToString = "Release" Then
                            strCmbSQL = "usp_Sel_tbl_PM_ScrumRelease_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Increment" Then
                            strCmbSQL = "usp_Sel_tbl_PM_ScrumIteration_OSCombination " + intProjectID + "," + intReleaseID


                            'ElseIf arrOSCombination(i).ToString = "Phase" Then
                            '    strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intProcessgroupID
                        End If
                        ''Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                        ''If arrOSCombination(i).ToString = "Phase" Or (strMandatory = "1" And arrOSCombination(i).ToString = "Iteration") Then
                        If arrOSCombination(i).ToString = "Phase" Then
                            ''End of Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                            If IsAgile <> "1" Then
                                ''Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                                'strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).ToString, strCmbSQL, 200, "", "", True, True, "clsComboBox", True))
                                strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).ToString, strCmbSQL, 200, "", "", True, True, "clsComboBox"))
                                ''End of Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                            End If
                        ElseIf arrOSCombination(i).ToString = "Release" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, "", "onchange=cboRelease_onChange()", True, True, "clsComboBox", True))
                        ElseIf arrOSCombination(i).ToString = "Increment" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, "", , True, True, "clsComboBox", True))
                        Else
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, "", "", True, True, "clsComboBox"))
                        End If
                        strSQL.Append("</TD></TR>")
                    Next
                Else
                    intSubprojectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProject"))
                    If intSubprojectID = "" Then
                        intSubprojectID = "NULL"
                    End If
                    intPhase = CommonFunctions.General.CheckIsNothing(Request.QueryString("Phase"))
                    If intPhase = "" Then
                        intPhase = "NULL"
                    End If
                    intMilestone = CommonFunctions.General.CheckIsNothing(Request.QueryString("Milestone"))
                    If intMilestone = "" Then
                        intMilestone = "NULL"
                    End If
                    intDeliverable = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectDeliverable"))
                    If intDeliverable = "" Then
                        intDeliverable = "NULL"
                    End If
                    intModule = CommonFunctions.General.CheckIsNothing(Request.QueryString("Module"))
                    If intModule = "" Then
                        intModule = "NULL"
                    End If
                    For i = 0 To arrOSCombination.Length - 1
                        strSQL.Append("<TR class=clsTRPageHeader><TD align=Right Width='30%'> " + Convert.ToString(arrOSCombination(i).Replace("Iteration", "Iteration/Release")) + "</td><td align=Left Width='70%'>&nbsp; ")

                        If arrOSCombination(i).ToString = "Sub Project" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_SubProject_OSCombination " + intProjectID + "," + intSubprojectID
                        ElseIf arrOSCombination(i).ToString = "Module" Then
                            strCmbSQL = "usp_Sel_tbl_PM_Module_OSCombination " + intProjectID + "," + intModule
                        ElseIf arrOSCombination(i).ToString = "Phase" Then
                            'strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intProcessgroupID
                            strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intPhase
                        ElseIf arrOSCombination(i).ToString = "Milestone" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_Milestone_OSCombination " + intProjectID + "," + intMilestone
                        ElseIf arrOSCombination(i).ToString = "Project Deliverable" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_Deliverables_OSCombination " + intProjectID + "," + intDeliverable
                        ElseIf arrOSCombination(i).ToString = "Release" Then
                            strCmbSQL = "usp_Sel_tbl_PM_ScrumRelease_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Increment" Then
                            strCmbSQL = "usp_Sel_tbl_PM_ScrumIteration_OSCombination " + intProjectID + "," + intReleaseID
                            'ElseIf arrOSCombination(i).ToString = "Phase" Then
                            '    strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intProcessgroupID
                        End If
                        ''Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                        '' If arrOSCombination(i).ToString = "Phase" Or (strMandatory = "1" And arrOSCombination(i).ToString = "Iteration") Then
                        ''End of Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                        If arrOSCombination(i).ToString = "Phase" Then
                            If IsAgile <> "1" Then
                                ''Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                                ''strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).ToString, strCmbSQL, 200, "", "", True, True, "clsComboBox", True))
                                strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).ToString, strCmbSQL, 200, "", "", True, True, "clsComboBox"))
                                ''End of Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                            End If
                        ElseIf arrOSCombination(i).ToString = "Release" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intReleaseID, "onchange=cboRelease_onChange()", True, True, "clsComboBox", True))
                        ElseIf arrOSCombination(i).ToString = "Sub Project" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intSubprojectID, "", True, True, "clsComboBox"))
                        ElseIf arrOSCombination(i).ToString = "Module" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intModule, "", True, True, "clsComboBox"))
                        ElseIf arrOSCombination(i).ToString = "Milestone" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intMilestone, "", True, True, "clsComboBox"))
                        ElseIf arrOSCombination(i).ToString = "Project Deliverable" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intDeliverable, "", True, True, "clsComboBox"))
                        Else
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, "", "", True, True, "clsComboBox", True))
                        End If
                        strSQL.Append("</TD></TR>")
                    Next
                End If
            Else
                If intReleaseID = "0" Then
                    For i = 0 To arrOSCombination.Length - 1
                        strSQL.Append("<TR class=clsTRPageHeader><TD align=Right Width='30%'> " + Convert.ToString(arrOSCombination(i).Replace("Iteration", "Iteration/Release")) + "</td><td align=Left Width='70%'>&nbsp; ")

                        If arrOSCombination(i).ToString = "Sub Project" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_SubProject_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Module" Then
                            'strCmbSQL = "usp_Sel_tbl_PM_Module " + intProjectID + ", NULL, 'A'"
                            strCmbSQL = "usp_Sel_tbl_PM_Module_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Phase" Then
                            'strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intProcessgroupID
                            strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Milestone" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_Milestone_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Project Deliverable" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_Deliverables_OSCombination " + intProjectID

                        ElseIf arrOSCombination(i).ToString = "Release" Then
                            strCmbSQL = "usp_Sel_tbl_PM_ScrumRelease_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Increment" Then
                            strCmbSQL = "usp_Sel_tbl_PM_ScrumIteration_OSCombination " + intProjectID + "," + intReleaseID


                            'ElseIf arrOSCombination(i).ToString = "Phase" Then
                            '    strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intProcessgroupID
                        End If
                        ''Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                        '' If arrOSCombination(i).ToString = "Phase" Or (strMandatory = "1" And arrOSCombination(i).ToString = "Iteration") Then
                        If arrOSCombination(i).ToString = "Phase" Then
                            ''End of Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                            ''Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                            ''strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).ToString, strCmbSQL, 200, "", "", True, True, "clsComboBox", True))
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).ToString, strCmbSQL, 200, "", "", True, True, "clsComboBox"))
                            ''End of Commented and Added By Nikhil A on 12-March-2016 To remove Phase As mandetory
                        ElseIf arrOSCombination(i).ToString = "Release" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, "", "onchange=cboRelease_onChange()", True, True, "clsComboBox"))

                        Else
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, "", "", True, True, "clsComboBox"))
                        End If
                        strSQL.Append("</TD></TR>")
                    Next
                Else
                    intSubprojectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProject"))
                    If intSubprojectID = "" Then
                        intSubprojectID = "NULL"
                    End If
                    intPhase = CommonFunctions.General.CheckIsNothing(Request.QueryString("Phase"))
                    If intPhase = "" Then
                        intPhase = "NULL"
                    End If
                    intMilestone = CommonFunctions.General.CheckIsNothing(Request.QueryString("Milestone"))
                    If intMilestone = "" Then
                        intMilestone = "NULL"
                    End If
                    intDeliverable = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectDeliverable"))
                    If intDeliverable = "" Then
                        intDeliverable = "NULL"
                    End If
                    intModule = CommonFunctions.General.CheckIsNothing(Request.QueryString("Module"))
                    If intModule = "" Then
                        intModule = "NULL"
                    End If
                    For i = 0 To arrOSCombination.Length - 1
                        strSQL.Append("<TR class=clsTRPageHeader><TD align=Right Width='30%'> " + Convert.ToString(arrOSCombination(i).Replace("Iteration", "Iteration/Release")) + "</td><td align=Left Width='70%'>&nbsp; ")

                        If arrOSCombination(i).ToString = "Sub Project" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_SubProject_OSCombination " + intProjectID + "," + intSubprojectID
                        ElseIf arrOSCombination(i).ToString = "Module" Then
                            strCmbSQL = "usp_Sel_tbl_PM_Module_OSCombination " + intProjectID + "," + intModule
                        ElseIf arrOSCombination(i).ToString = "Phase" Then
                            'strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intProcessgroupID
                            strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intPhase
                        ElseIf arrOSCombination(i).ToString = "Milestone" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_Milestone_OSCombination " + intProjectID + "," + intMilestone
                        ElseIf arrOSCombination(i).ToString = "Project Deliverable" Then
                            strCmbSQL = "usp_Sel_WPBN_tbl_PM_Deliverables_OSCombination " + intProjectID + "," + intDeliverable
                        ElseIf arrOSCombination(i).ToString = "Release" Then
                            strCmbSQL = "usp_Sel_tbl_PM_ScrumRelease_OSCombination " + intProjectID
                        ElseIf arrOSCombination(i).ToString = "Increment" Then
                            strCmbSQL = "usp_Sel_tbl_PM_ScrumIteration_OSCombination " + intProjectID + "," + intReleaseID
                            'ElseIf arrOSCombination(i).ToString = "Phase" Then
                            '    strCmbSQL = "usp_Sel_tbl_IB_Project_Phases_OSCombination " + intProjectID + "," + intProcessgroupID
                        End If
                        ''If arrOSCombination(i).ToString = "Phase" Or (strMandatory = "1" And arrOSCombination(i).ToString = "Iteration") Then
                        If arrOSCombination(i).ToString = "Phase" Then
                            ''strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).ToString, strCmbSQL, 200, "", "", True, True, "clsComboBox", True))
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).ToString, strCmbSQL, 200, "", "", True, True, "clsComboBox"))
                        ElseIf arrOSCombination(i).ToString = "Release" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intReleaseID, "onchange=cboRelease_onChange()", True, True, "clsComboBox"))
                        ElseIf arrOSCombination(i).ToString = "Sub Project" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intSubprojectID, "", True, True, "clsComboBox"))
                        ElseIf arrOSCombination(i).ToString = "Module" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intModule, "", True, True, "clsComboBox"))
                        ElseIf arrOSCombination(i).ToString = "Milestone" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intMilestone, "", True, True, "clsComboBox"))
                        ElseIf arrOSCombination(i).ToString = "Project Deliverable" Then
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, intDeliverable, "", True, True, "clsComboBox"))
                        Else
                            strSQL.Append(CommonFunctions.HTMLControls.DrawComboBox(arrOSCombination(i).Replace(" ", ""), strCmbSQL, 200, "", "", True, True, "clsComboBox"))
                        End If
                        strSQL.Append("</TD></TR>")
                    Next
                End If
            End If
            strSQL.Append("</TABLE>")
            strSQL.Append("</Div>")
            'strSQL.Append(GenerateMenu())
            Response.Write(strSQL.ToString)

        End If
    End Sub
    'Chakshuta
    Private Sub DeleteDetails()

        Dim strDeleteIDs As String = CommonFunctions.General.CheckIsNothing(Request.Form("chkDelete"))
        If strDeleteIDs <> "" Then
            CommonFunctions.Data.InsertOrUpdateData("Exec usp_Del_tbl_PM_BillingCalendarDetails  '" & strDeleteIDs.ToString & "'", True)
        End If

    End Sub
    'Chakshuta
    Protected Function GenerateMenu() As String
        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList
        Dim ArrTopImageList As New ArrayList
        'Modified by RathinP on 21 Aug 2009 to Change the Link Names
        ArrTopMenuCaptionsList.Add("Save")
        ArrTopMenuToolTipsList.Add("Save")
        ArrTopMenuFunctionsList.Add("Save_OnClick()")
        ArrTopImageList.Add("../../Images/cssImages/Link images/SAVE.gif")

        ArrTopMenuCaptionsList.Add("Save and Add")
        ArrTopMenuToolTipsList.Add("Save and Add")
        ArrTopMenuFunctionsList.Add("SaveAdd_OnClick()")
        ArrTopImageList.Add("../../Images/cssImages/Link images/saveadd.gif")

        ArrTopMenuCaptionsList.Add("Close")
        ArrTopMenuToolTipsList.Add("Close")
        ArrTopMenuFunctionsList.Add("Close_OnClick()")
        ArrTopImageList.Add("../../Images/cssImages/Link images/Close.gif")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        Dim ArrTopMenuImageList(ArrTopImageList.Count - 1) As String
        ArrTopImageList.ToArray.CopyTo(ArrTopMenuImageList, 0)
        ArrTopImageList = Nothing

        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True, , , ArrTopMenuImageList) + "<BR>"
    End Function

    Protected Function GeneratePageCaption() As String
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : To Generate Page Caption
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : RathinP
        ' Created               : 11 Aug 2009
        ' Revisions             :
        '=====================================================================
        Return WebPages.Template.PageCaption.GetPageCaptions(, "Overall Schedule Combination", , , True)
    End Function

    Protected Function PlotNote() As String
        Dim strPlot As String = "<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> OS Combinations will be created based on Attribute selection done on this page. Iteration field is mandatory if the project is following Development model with iterations defined or if the project is a Release Based Maintenance project.</TD></TR></TABLE>"
        Return CStr(strPlot)
    End Function
End Class