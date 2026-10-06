
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Data.SqlClient

'/ <summary>
'/ Summary description for WhizProcessFunctions
'/ </summary>

Public Class WhizProcessFunctions
    ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    Inherits WebPages.Template.WhizTemplate
    ''End of Addition by Dhanashri S on 10 Oct 2016

#Region "Variables"
    Private Shared strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
#End Region


    Public Sub New()
        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

    End Sub 'New

    '
    ' TODO: Add constructor logic here
    '

    Public Shared Sub ProcessTreeDataset(ByRef objDS As DataSet, strSQL As String)
        'string strConnectionString = "";
        'strConnectionString = ConfigurationManager.AppSettings.Get("ConnectionString1");
        objDS = New DataSet()
        Dim objDA As New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)
        If Not (objDA Is Nothing) Then
            objDA = Nothing
        End If
    End Sub 'ProcessTreeDataset

    Public Shared Sub GenerateDataSet(ByRef objDS As DataSet, PKID As String)
        Dim strSQL As String = ""
        'string strConnectionString = ConfigurationManager.AppSettings.Get("ConnectionString1");
        Dim strChar(0) As Char
        strChar(0) = System.Convert.ToChar("|")
        objDS = New DataSet()
        Dim objDA As SqlDataAdapter = Nothing
        'first split primary key to find out from where this is called
        Dim arrVal As String() = PKID.Split(strChar)

        If arrVal.Length > 1 Then
            'level is stored at first location so get the level of tree node
            Select Case arrVal(1).ToString()
                Case "PS"
                    'this is first level i.e. all processes should be shown
                    strSQL = "SELECT ProcessID,ProcessName,EntryCriteria,ExitCriteria FROM tbl_PRS_Process_Draft ORDER BY ProcessName"

                Case "P"
                    'This is the case where only one process is selected 
                    'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                    'strSQL = "SELECT ActivityID,ProcessID,Title,[Description] FROM tbl_PRS_Activity_Draft WHERE ProcessID = " + arrVal(2).ToString()
                    strSQL = "usp_sel_tbl_PRS_Activity_Draft_ActivityID " + arrVal(2).ToString()
                    'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            End Select
            If strSQL <> "" Then
                objDA = New SqlDataAdapter(strSQL, strConnectionString)
                objDA.Fill(objDS)
            End If
            If Not (objDA Is Nothing) Then
                objDA = Nothing
            End If
        End If
    End Sub 'GenerateDataSet

    Public Shared Sub DeleteRecord(strPKID As String, strItemID As String)
        Dim strSQL As String = ""
        'string strConnectionString = ConfigurationManager.AppSettings.Get("ConnectionString1");
        Dim objCon As New SqlConnection(strConnectionString)
        Dim objCom As SqlCommand = Nothing 'new SqlCommand();
        Dim strChar(0) As Char
        strChar(0) = System.Convert.ToChar("|")
        'first split primary key to find out from where this is called
        Dim arrVal As String() = strPKID.Split(strChar)
        Dim strResult As String = ""
        If arrVal.Length > 1 Then 'Clicked in one of the hierarchy node
            'level is stored at first location so get the level of tree node
            Select Case arrVal(1).ToString()
                Case "PS", "TS", "GS", "CS", "MS", "PT"
                    'User wants to view all processes
                    strSQL = "USP_VPM_DEL_ITEMS " + arrVal(0) + "," + arrVal(1) + ",NULL,'" + strItemID + "'"
                Case "P", "T", "G", "C", "M", "AS", "TK"
                    strSQL = "USP_VPM_DEL_ITEMS " + arrVal(0) + ",'" + arrVal(1) + "'," + arrVal(2) + ",'" + strItemID + "'"
            End Select

            'Clicked on ROOT node
        Else
            strSQL = "USP_VPM_DEL_ITEMS"
        End If
        If strSQL <> "" Then
            objCon.Open()
            objCom = New SqlCommand(strSQL, objCon)
            strResult = System.Convert.ToString(objCom.ExecuteScalar())
            If objCon.State = ConnectionState.Open Then
                objCon.Close()
            End If
            If Not (objCom Is Nothing) Then
                objCom = Nothing
            End If
            If Not (objCon Is Nothing) Then
                objCon = Nothing
            End If
            If strResult <> "" Then
                CommonFunctions.General.WriteHTML("<script language='javascript' type='text/javascript'>")
                CommonFunctions.General.WriteHTML((" alert(""" + strResult.Replace("""", "\""") + """);"))
                CommonFunctions.General.WriteHTML("</script>")
            End If
        End If
    End Sub 'DeleteRecord


    Public Shared Sub GenerateDynamicDataSet(ByRef objDS As DataSet, PKID As String)
        Dim strSQL As String = ""
        ' string strConnectionString = ConfigurationManager.AppSettings.Get("ConnectionString1");
        Dim strChar(0) As Char
        strChar(0) = System.Convert.ToChar("|")
        objDS = New DataSet()
        Dim objDA As SqlDataAdapter = Nothing
        'first split primary key to find out from where this is called
        Dim arrVal As String() = PKID.Split(strChar)

        If arrVal.Length > 1 Then 'Clicked in one of the hierarchy node
            'level is stored at first location so get the level of tree node
            Select Case arrVal(1).ToString()
                Case "PS", "TS", "GS", "CS", "MS", "PT"
                    'User wants to view all processes
                    strSQL = "USP_VPM_GetProcessesData " + arrVal(0) + "," + arrVal(1)
                Case "P", "T", "G", "C", "M", "AS", "TK"
                    strSQL = "USP_VPM_GetProcessesData " + arrVal(0) + ",'" + arrVal(1) + "'," + arrVal(2)
            End Select

            'Clicked on ROOT node
        Else
            strSQL = "USP_VPM_GetProcessesData"
        End If
        If strSQL <> "" Then
            objDA = New SqlDataAdapter(strSQL, strConnectionString)
            objDA.Fill(objDS)
        End If
        If Not (objDA Is Nothing) Then
            objDA = Nothing
        End If
    End Sub 'GenerateDynamicDataSet

    Public Shared Sub SetProcessstatus(intProcessID As Integer, strStatus As String)
        Dim strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
        Dim blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))

        CommonFunctions.Data.InsertOrUpdateData("usp_upd_tbl_PRS_Process_Status " + intProcessID.ToString() + " , '" + strStatus + "'", blnUseSQL, strConnectionString)
    End Sub 'SetProcessstatus


    Public Shared Sub SetProcessActivityStatus(intActivityID As Integer, strStatus As String)
        Dim strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
        Dim blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))

        CommonFunctions.Data.InsertOrUpdateData(" usp_upd_tbl_PRS_Activity_Status " + intActivityID.ToString() + " , '" + strStatus + "'", blnUseSQL, strConnectionString)
    End Sub 'SetProcessActivityStatus 
End Class 'WhizProcessFunctions