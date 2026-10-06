'PAGE ADDED BY NITINC FOR WHIZIBLESEM V10.0 (AGILE METHODOLOGY)
Imports CommonFunctions.General
Imports CommonFunctions.Data
Partial Public Class AjaxCallIteration
    '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
      ' Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection

        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'ADDEED BY AMIT MAHADIK ON 02 JUNE 2011 WHIZIBLESEM 10.0,ITERATION START-END DATE VALIDATIONS
        If CheckIsNothing(Request.QueryString("Flag"), "") = "UpdPrioritize" Then

            Dim strSourceElement As String = CheckIsNothing(Request.QueryString("SourceElement"), "")
            Dim strDestinationElement As String = CheckIsNothing(Request.QueryString("DestinationElement"), "")


            Dim strQuery As String
            strQuery = "Exec usp_upd_tbl_PM_ScrumPrioritize " + strSourceElement + "," + strDestinationElement ''+ ",'" + Convert.ToDateTime(StartDate).ToString("dd-MMM-yyyy") + "','" + Convert.ToDateTime(EndDate).ToString("dd-MMM-yyyy") + "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            Response.Clear()
            Response.Write("TRUE")
            Response.End()
        End If
        'Added by NitinC on 18 Jan 2012 For WhizibleSEM 11.0 - Agile Module (Issue Fix : 58806)
        If CheckIsNothing(Request.QueryString("Flag"), "") = "GraphicalView" Then
            TaskDateValidation(CheckIsNothing(Request.QueryString("Flag"), ""), CheckIsNothing(Request.QueryString("StartDate"), ""), CheckIsNothing(Request.QueryString("EndDate"), ""), CheckIsNothing(Request.QueryString("ID"), ""))
        End If
        'End of Added by NitinC on 18 Jan 2012 For WhizibleSEM 11.0 - Agile Module (Issue Fix : 58806)

        'Added Project Flag By Syamantak Chavan On 29 July 2011
        If CheckIsNothing(Request.QueryString("Flag"), "") = "Release" Or CheckIsNothing(Request.QueryString("Flag"), "") = "Project" Or CheckIsNothing(Request.QueryString("Flag"), "") = "Iteration" Or CheckIsNothing(Request.QueryString("Flag"), "") = "UserStory" Then
            DateValitation(CheckIsNothing(Request.QueryString("Flag"), ""), CheckIsNothing(Request.QueryString("StartDate"), ""), CheckIsNothing(Request.QueryString("EndDate"), ""), CheckIsNothing(Request.QueryString("ID"), ""))
            'Dim ValidationResponseText As New StringBuilder
            'ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
            'Dim strQuery As String
            'Dim IterationStartDate As String = CheckIsNothing(Request.QueryString("StartDate"), "")
            'Dim IterationEndDate As String = CheckIsNothing(Request.QueryString("EndDate"), "")
            'Dim ReleaseID As String = CheckIsNothing(Request.QueryString("ReleaseID"), "")
            'strQuery = "Exec usp_IterationSDEDvalidations Iteration, " + ReleaseID + ",'" + IterationStartDate + "','" + IterationEndDate + "'"
            '''''Dim isValid As Boolean = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))
            'Dim drValidationDate As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
            'If (drValidationDate.HasRows) Then
            '    While (drValidationDate.Read())
            '        ValidationResponseText.Append(drValidationDate(0).ToString())
            '        ValidationResponseText.Append(",")
            '        ValidationResponseText.Append(drValidationDate(1).ToString())
            '        ValidationResponseText.Append(",")
            '        ValidationResponseText.Append(drValidationDate(2).ToString())
            '    End While
            'Else
            'End If
            'Response.Write(ValidationResponseText)

            ''''If isValid Then
            ''''    Response.Write("True")
            ''''Else
            ''''    Response.Write("False")
            ''''End If

            'Response.End()
        End If
        'End ADDEED BY AMIT MAHADIK ON 02 JUNE 2011 WHIZIBLESEM 10.0,ITERATION START-END DATE VALIDATIONS

        If CheckIsNothing(Request.QueryString("Flag"), "") = "DeleteEntityValitation" Then
            DeleteEntityValitation(CheckIsNothing(Request.QueryString("Entity"), ""), CheckIsNothing(Request.QueryString("IDs"), ""))
        End If
        If CheckIsNothing(Request.QueryString("Flag"), "") = "AssignedTask" Then
            GetUserStoryDetails(CheckIsNothing(Request.QueryString("UserStoryID"), ""))
        End If
        If CheckIsNothing(Request.QueryString("ReleaseId")) <> "" And CheckIsNothing(Request.QueryString("EntityName")) = "Issue" Then
            Dim strSql As String
            Dim ReleaseId As Integer
            ReleaseId = CInt(Request.QueryString("ReleaseId"))
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSql = "select IterationID,IterationName from tbl_PM_ScrumIteration where ReleaseID = " + ReleaseId.ToString() + " order by IterationName"
            strSql = "usp_sel_tbl_PM_ScrumIteration_ReleaseIDWise_IterationID_IterationName " + ReleaseId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Dim drIterations As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSql)
            Dim Iterations As New System.Text.StringBuilder
            If (drIterations.HasRows) Then
                While (drIterations.Read())
                    Iterations.Append(",")
                    Iterations.Append(drIterations(0).ToString())
                    Iterations.Append("$--$")
                    Iterations.Append(drIterations(1).ToString())
                End While
            Else
                Iterations.Append(",")
                Iterations.Append("Not Available")
                Iterations.Append("$--$")
                Iterations.Append("Not Available")
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drIterations, SqlClient.SqlDataReader))

            'strSql = "select BuildID,BuildName from tbl_PM_ScrumBuild where ReleaseID = " + ReleaseId.ToString() + " order by BuildName"
            'drIterations = CommonFunctions.Data.GetSQLDataReader(strSql)
            'If (drIterations.HasRows) Then
            '    While (drIterations.Read())
            '        Iterations.Append(",")
            '        Iterations.Append(drIterations(0).ToString())
            '        Iterations.Append("@--@")
            '        Iterations.Append(drIterations(1).ToString())
            '    End While
            'Else
            '    Iterations.Append(",")
            '    Iterations.Append("Not Available")
            '    Iterations.Append("@--@")
            '    Iterations.Append("Not Available")
            'End If
            'CommonFunctions.Data.DisposeDataReader(CType(drIterations, SqlClient.SqlDataReader))

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSql = "select UserStoryID,UserStoryName from tbl_PM_ScrumUserStory where ReleaseID = " + ReleaseId.ToString() + " order by UserStoryName"
            strSql = "usp_sel_tbl_PM_ScrumUserStory_UserStoryID_UserStoryName " + ReleaseId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            drIterations = CommonFunctions.Data.GetSQLDataReader(strSql)
            If (drIterations.HasRows) Then
                While (drIterations.Read())
                    Iterations.Append(",")
                    Iterations.Append(drIterations(0).ToString())
                    Iterations.Append("#--#")
                    Iterations.Append(drIterations(1).ToString())
                End While
            Else
                Iterations.Append(",")
                Iterations.Append("Not Available")
                Iterations.Append("#--#")
                Iterations.Append("Not Available")
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drIterations, SqlClient.SqlDataReader))

            Response.Clear()
            Response.Write(Iterations.ToString)
            Response.End()
            Exit Sub
        ElseIf CheckIsNothing(Request.QueryString("ReleaseId")) <> "" And CheckIsNothing(Request.QueryString("EntityName")) = "UserStory" Or CheckIsNothing(Request.QueryString("ReleaseId")) <> "" And CheckIsNothing(Request.QueryString("EntityName")) = "Build" Then
            Dim strSql As String
            Dim ReleaseId As Integer
            ReleaseId = CInt(Request.QueryString("ReleaseId"))

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSql = "select IterationID,IterationName from tbl_PM_ScrumIteration where ReleaseID = " + ReleaseId.ToString() + " order by IterationName"
            strSql = "usp_sel_tbl_PM_ScrumIteration_ReleaseIDWise_IterationID_IterationName " + ReleaseId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            Dim drIterations As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSql)
            Dim Iterations As New System.Text.StringBuilder
            If (drIterations.HasRows) Then
                While (drIterations.Read())
                    Iterations.Append(",")
                    Iterations.Append(drIterations(0).ToString())
                    Iterations.Append("$--$")
                    Iterations.Append(drIterations(1).ToString())
                End While
            Else
                Iterations.Append("Not Available")
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drIterations, SqlClient.SqlDataReader))
            Response.Clear()
            Response.Write(Iterations.ToString)
            Response.End()
            Exit Sub
        ElseIf CheckIsNothing(Request.QueryString("IterationId")) <> "" And CheckIsNothing(Request.QueryString("Action")) = "GetUserStory" Then
            Dim strSql As String
            Dim IterationId As Integer
            IterationId = CInt(Request.QueryString("IterationId"))
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSql = "select UserStoryID,UserStoryName from tbl_PM_ScrumUserStory where IterationId = " + IterationId.ToString() + " order by UserStoryName"
            strSql = "usp_sel_tbl_PM_ScrumUserStory_IterationWise_UserStoryID_UserStoryName " + IterationId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            Dim drUserStories As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSql)
            Dim UserStories As New System.Text.StringBuilder
            If (drUserStories.HasRows) Then
                While (drUserStories.Read())
                    UserStories.Append(",")
                    UserStories.Append(drUserStories(0).ToString())
                    UserStories.Append("$--$")
                    UserStories.Append(drUserStories(1).ToString())
                End While
            Else
                UserStories.Append("")
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drUserStories, SqlClient.SqlDataReader))
            Response.Clear()
            Response.Write(UserStories.ToString)
            Response.End()
            Exit Sub
        ElseIf CheckIsNothing(Request.QueryString("IterationId")) <> "" And CheckIsNothing(Request.QueryString("EntityName")) = "UserStory" Then
            Dim strSql As String
            Dim IterationId As Integer
            IterationId = CInt(Request.QueryString("IterationId"))
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strSql = "select StartDate,EndDate,CONVERT(INT,Velocity) AS Velocity from tbl_PM_ScrumIteration where IterationId = " + IterationId.ToString() + " and StartDate is not null"
            strSql = "usp_sel_tbl_PM_ScrumIteration_StartDate_EndDate_Velocity " + IterationId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            Dim drIterations As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSql)
            Dim Iterations As New System.Text.StringBuilder
            If (drIterations.HasRows) Then
                While (drIterations.Read())

                    Iterations.Append(Convert.ToDateTime(drIterations(0).ToString()).ToString("dd/MM/yyyy"))
                    Iterations.Append(",")
                    Iterations.Append(Convert.ToDateTime(drIterations(1).ToString()).ToString("dd/MM/yyyy"))
                    Iterations.Append(",")
                    Iterations.Append(Convert.ToDateTime(drIterations(0).ToString()).ToString("dd-MMM-yyyy"))
                    Iterations.Append(",")
                    Iterations.Append(Convert.ToDateTime(drIterations(1).ToString()).ToString("dd-MMM-yyyy"))
                    Iterations.Append(",")
                    Iterations.Append(drIterations("Velocity").ToString)

                End While
            Else
                Iterations.Append("Not Available")
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drIterations, SqlClient.SqlDataReader))
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSql = "select CASE WHEN CONVERT(INT,SUM(InitialEstimate)) IS NULL THEN 0 ELSE CONVERT(INT,SUM(InitialEstimate)) END AS InitialEstimate from tbl_PM_ScrumUserStory where IterationId = " + IterationId.ToString()
            strSql = "usp_sel_tbl_PM_ScrumUserStory_InitialEstimate " + IterationId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            drIterations = CommonFunctions.Data.GetSQLDataReader(strSql)
            If (drIterations.HasRows) Then
                While (drIterations.Read())
                    Iterations.Append(",")
                    Iterations.Append(drIterations("InitialEstimate").ToString)
                End While
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drIterations, SqlClient.SqlDataReader))
            Response.Clear()
            Response.Write(Iterations.ToString)
            Response.End()
            Exit Sub
        Else

            Page_Load(sender, e)

        End If


    End Sub
    Protected Sub GetUserStoryDetails(ByVal UserStoryID As String)
        Dim UserStoryResponseText As New StringBuilder
        UserStoryResponseText.Remove(0, UserStoryResponseText.Length) ''EMPTY STRING
        Dim strQuery As String
        strQuery = "Exec Usp_Sel_Scrum_UserStories 'UserStoryDetails'," + Session("intProjectID").ToString + "," + UserStoryID
        Dim drUSDetails As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
        If (drUSDetails.HasRows) Then
            While (drUSDetails.Read())
                UserStoryResponseText.Append(drUSDetails(0).ToString())
                UserStoryResponseText.Append(",")
                UserStoryResponseText.Append(drUSDetails(1).ToString())
                UserStoryResponseText.Append(",")
                UserStoryResponseText.Append(drUSDetails(2).ToString())
                ''Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes 
                UserStoryResponseText.Append(",")
                UserStoryResponseText.Append(drUSDetails(3).ToString())
                ''End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes 
            End While
        End If
        Response.Write(UserStoryResponseText)
        Response.End()
    End Sub
    Protected Sub DeleteEntityValitation(ByVal Entity As String, ByVal IDs As String)
        Dim ValidationResponseText As New StringBuilder
        ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
        Dim strQuery As String
        Dim strMessage As String = ""
        strQuery = "Exec usp_ScrumEntityDeleteValidation '" + Entity + "','" + IDs + "'"
        Dim drEntityValidation As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
        If (drEntityValidation.HasRows) Then
            While (drEntityValidation.Read())
                ValidationResponseText.Append(drEntityValidation(0).ToString())
            End While
        Else
        End If
        Response.Write(ValidationResponseText)
        Response.End()
    End Sub
    'Added by NitinC on 18 Jan 2012 For WhizibleSEM 11.0 - Agile Module (Issue Fix : 58806)
    Protected Sub TaskDateValidation(ByVal Flag As String, ByVal StartDate As String, ByVal EndDate As String, ByVal ID As String)
        Dim ValidationResponseText As New StringBuilder
        ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
        Dim strQuery As String
        strQuery = "Exec usp_TaskDateValidation " + Flag + "," + ID + ",'" + Convert.ToDateTime(StartDate).ToString("dd-MMM-yyyy") + "','" + Convert.ToDateTime(EndDate).ToString("dd-MMM-yyyy") + "'"
        Dim drValidationDate As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
        If (drValidationDate.HasRows) Then
            While (drValidationDate.Read())
                ValidationResponseText.Append(drValidationDate(0).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(drValidationDate(1).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(drValidationDate(2).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(drValidationDate(3).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(drValidationDate(4).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(drValidationDate(5).ToString())
            End While
        Else
        End If
        Response.Write(ValidationResponseText)
        Response.End()
    End Sub
    'End of Added by NitinC on 18 Jan 2012 For WhizibleSEM 11.0 - Agile Module (Issue Fix : 58806)

    Protected Sub DateValitation(ByVal Flag As String, ByVal StartDate As String, ByVal EndDate As String, ByVal ID As String)
        Dim ValidationResponseText As New StringBuilder
        ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
        Dim strQuery As String
        If Flag = "Project" Or Flag = "Release" Then
            strQuery = "Exec usp_IterationSDEDvalidations " + Flag + "," + ID + ",'" + Convert.ToDateTime(StartDate).ToString("dd-MMM-yyyy") + "','" + Convert.ToDateTime(EndDate).ToString("dd-MMM-yyyy") + "'," + Request.QueryString("Duration").ToString + "," + Request.QueryString("Velocity").ToString
        ElseIf Flag = "Iteration" Then
            strQuery = "Exec usp_IterationSDEDvalidations " + Flag + "," + ID + ",'" + Convert.ToDateTime(StartDate).ToString("dd-MMM-yyyy") + "','" + Convert.ToDateTime(EndDate).ToString("dd-MMM-yyyy") + "',NULL,NULL," + Request.QueryString("UserStoryID").ToString
        Else
            strQuery = "Exec usp_IterationSDEDvalidations " + Flag + "," + ID + ",'" + Convert.ToDateTime(StartDate).ToString("dd-MMM-yyyy") + "','" + Convert.ToDateTime(EndDate).ToString("dd-MMM-yyyy") + "'"
        End If
        Dim drValidationDate As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
        If (drValidationDate.HasRows) Then
            While (drValidationDate.Read())
                ValidationResponseText.Append(drValidationDate(0).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(drValidationDate(1).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(drValidationDate(2).ToString())
                If Flag = "Project" Or Flag = "Release" Then
                    ValidationResponseText.Append(",")
                    ValidationResponseText.Append(drValidationDate(3).ToString())
                End If
                If Flag = "UserStory" Then
                    ValidationResponseText.Append(",")
                    ValidationResponseText.Append(drValidationDate(3).ToString())
                    ValidationResponseText.Append(",")
                    ValidationResponseText.Append(drValidationDate(4).ToString())
                    ValidationResponseText.Append(",")
                    ValidationResponseText.Append(drValidationDate(5).ToString())
                End If

            End While
        Else
        End If
        Response.Write(ValidationResponseText)

        '''If isValid Then
        '''    Response.Write("True")
        '''Else
        '''    Response.Write("False")
        '''End If

        Response.End()
    End Sub
End Class