Imports CommonEngines.General.cEventHandlers
Public Class EmployeeLeaves_CommonList
    Inherits CommonList

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = " EmployeeLeaves_CommonList.aspx"
        MyBase.strFormPage = "EmployeeLeaves_CommonPage.aspx"
        'Put user code to initialize the page here
        'Comment and Addition done by SuchitraP on 26-July-2007
        'MyBase.Page_Load(sender, e)
        If Request.Params("FromXML") = "1" Then
            Response.Clear()
            Response.Write(GetLeaveIDs)
            Response.End()
        Else
            MyBase.Page_Load(sender, e)
        End If
        'End of comment and addition by SuchitraP on 26-July-2007

    End Sub
#End Region

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cEmployeeLeave_PlotGrid(MyBase.m_objGlobal)
    End Function

    'Addition done by SuchitraP on 26-July-2007
    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strFunction As String
        Dim strLeaveID As String
        Dim sql As String
        Dim blnHasRecord As Boolean
        If Args.ClientSideFunctionName.ToUpper = "HYPERLINK2" Then
            Dim strScript As String
            strScript = "var url;" + vbCrLf
            strScript += " url = new String();" + vbCrLf
            strScript += " " + vbCrLf

            strScript += "url='../HR/EmployeeLeaves_CommonList.aspx?TagID=1209&FromXML=1&LeaveID=' + LeaveID  ;" + vbCrLf
            strScript += "loadXMLDoc(url,'');return;" + vbCrLf

            Args.ToBeInserted = strScript
        End If
    End Sub
    'End of addition done by SuchitraP on 26-July-2007
    'Addition done by SuchitraP on 26-July-2007
    Private Function GetLeaveIDs() As String
        '=====================================================================
        ' Procedure Name		:	GetLeaveID
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To return LeaveID or Leave dates to AJAX response.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SuchitraP
        ' Created				:	26 July 2007
        ' Revisions				:	
        '=====================================================================
        Dim strLeaveID As String
        Dim sql As String
        Dim sbHtml As System.Text.StringBuilder = New System.Text.StringBuilder
        Dim strHtml, str As String
        Dim dr As IDataReader
        Dim count As Integer
        count = 0
        strLeaveID = HttpContext.Current.Request.Params("LeaveID")
        If strLeaveID <> "" Then
            sql = "EXEC usp_Sel_EmployeeLeaveDetails_Rejected " + strLeaveID
            'strHtml = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(sql, True), ""), ""), String)
            dr = CommonFunction.Data.GetDataReader(sql, True)
            While dr.Read
                If count = 0 Then
                    sbHtml.Append("0|")
                End If
                sbHtml.Append(dr("LeaveDate").ToString)
                sbHtml.Append("|")
                count += 1
            End While
        End If

        strHtml = sbHtml.ToString

        'strHtml = strHtml.Substring(0, sbHtml.Length - 1)
        CommonFunction.Data.DisposeDataReader(dr)


        If Not strHtml = "" Then
            strHtml = strHtml.Substring(0, sbHtml.Length - 1)
            Return strHtml
        Else
            sbHtml.Append("1|")
            sbHtml.Append(strLeaveID)
            str = sbHtml.ToString
            sbHtml = Nothing
            Return str
        End If

    End Function
    'End of addition by SuchitraP on 26-July-2007

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strHtm As String
        strHtm = "function loadXMLDoc(url,reqQuery){" + vbCrLf
        'strHtm += "alert('loadXML'); " + vbCrLf
        strHtm += "if (window.XMLHttpRequest) {" + vbCrLf
        strHtm += "xmlhttp=new XMLHttpRequest();" + vbCrLf
        strHtm += "xmlhttp.onreadystatechange=state_Change;" + vbCrLf
        strHtm += "if (ns) {" + vbCrLf
        'Modification done by SuchitraP on 21-Nov-2007 for IssueID 16581
        'Purpose: The Leave Approver do not able to approve the leave in firefox
        strHtm += "if (reqQuery!=null || reqQuery!=''){" + vbCrLf
        strHtm += "xmlhttp.open(""GET"",url+""&""+reqQuery,true);}" + vbCrLf
        strHtm += "else{" + vbCrLf
        strHtm += "xmlhttp.open(""GET"",url,true);}" + vbCrLf
        strHtm += "xmlhttp.send(null);" + vbCrLf
        'End of modification by SuchitraP on 21-Nov-2007 for IssueID 16581
        strHtm += "}" + vbCrLf
        strHtm += "else {" + vbCrLf
        strHtm += "xmlhttp.open(""POST"",url,false);" + vbCrLf
        strHtm += "xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');" + vbCrLf
        strHtm += "xmlhttp.send(reqQuery);" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "else if (window.ActiveXObject) {" + vbCrLf
        strHtm += "xmlhttp=new ActiveXObject(""Microsoft.XMLHTTP"");" + vbCrLf
        strHtm += "if (xmlhttp) {" + vbCrLf
        'strHtm += "alert('if');" + vbCrLf
        strHtm += "xmlhttp.onreadystatechange=state_Change;" + vbCrLf
        strHtm += "xmlhttp.open(""POST"",url,false);" + vbCrLf
        strHtm += "xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');" + vbCrLf
        strHtm += "xmlhttp.send(reqQuery)" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "}" + vbCrLf

        strHtm += "var arrOptions;" + vbCrLf
        strHtm += "var iterator;" + vbCrLf
        strHtm += "var i;" + vbCrLf
        strHtm += "function state_Change() {"
        strHtm += "var str='';" + vbCrLf
        strHtm += "var showDates='';" + vbCrLf
        strHtm += "var strDates='';" + vbCrLf
        'strHtm += "alert('state_Change');" + vbCrLf
        strHtm += "if (xmlhttp.readyState==4)" + vbCrLf
        strHtm += "{" + vbCrLf
        strHtm += "if (xmlhttp.status==200)" + vbCrLf
        strHtm += "{" + vbCrLf
        '------------------------------------------------------------
        strHtm += "var str=xmlhttp.responseText;" + vbCrLf
        'strHtm += "alert(str);" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "if(str!=null && str!=''){" + vbCrLf
        strHtm += "arrOptions=str.split(""|"");" + vbCrLf
        'strHtm += "alert(arrOptions);" + vbCrLf
        'strHtm += "for(iterator=0;iterator<arrOptions.length;iterator=iterator+1){" + vbCrLf
        strHtm += "if(arrOptions[0]==1){" + vbCrLf
        strHtm += "window.open ('../HR/HR_AddComments.aspx?Mode=Approve&LeaveID=' + arrOptions[1],'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 250)/2 + ',width=600,height=250');" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "if(arrOptions[0]==0){" + vbCrLf
        strHtm += "for(iterator=1;iterator<arrOptions.length;iterator=iterator+1){" + vbCrLf
        strHtm += "strDates+=arrOptions[iterator]+','" + vbCrLf
        strHtm += "}" + vbCrLf

        'strHtm += "if (xmlhttp.responseText==0) " + vbCrLf
        'strHtm += "{" + vbCrLf
        'strHtm += "window.open ('../HR/HR_AddComments.aspx?Mode=Approve&LeaveID=' + xmlhttp.responseText,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 250)/2 + ',width=600,height=250');" + vbCrLf
        'strHtm += "}" + vbCrLf
        'strHtm += "else {" + vbCrLf
        'strHtm += "alert('Employee has already submitted leave for this Date');return;" + vbCrLf
        'strHtm += "}" + vbCrLf
        'strHtm += "}" + vbCrLf
        strHtm += "showDates = replaceSubstring(strDates.substring(0,strDates.length-1),',',',\n');" + vbCrLf
        'strHtm += "showDates=replaceSubstring(showDates,',',',\n');" + vbCrLf
        strHtm += "alert('Leave has already been applied for \n'+showDates);" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "}" + vbCrLf
        strHtm += "}" + vbCrLf

        'Response.Write(strHtm)
        CommonFunction.General.WriteHTML("<script>" + strHtm + "</script>")

    End Function
End Class

Public Class cEmployeeLeave_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.ParentTagID = 0 Then
            'For Master Tag
            If Args.ColumnName.ToUpper = "DELETE" Then
                Cancel = True
            End If
        Else
        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.ParentTagID = 0 Then
            'For Master Tag
            Dim lngLeaveID As Long = 0
            Dim lngLeaveStatusID As Long = 0
            Dim Flag As Boolean = False
            'Added By VarunA on 18-Aug-2008 (For Whiziblesem8 Enhancement)
            'Purpose : No one can change leave details on inactive resources.
            Dim EmpStatus As Boolean = False
            EmpStatus = CType(Args.DataReader.Item("Status"), Boolean)
            'End By Varun on 18-Aug-2008 (For Whiziblesem8 Enhancement)

            lngLeaveID = CType(Args.DataReader.Item("LeaveID"), Long)
            lngLeaveStatusID = CType(Args.DataReader.Item("LeaveStatusID"), Long)

            If (Args.ColumnName.ToUpper = "APPROVE") Then
                'Added By VarunA on 18-Aug-2008 (For Whiziblesem8 Enhancement)
                'Purpose : No one can change leave details on inactive resources.
                If EmpStatus = True Then
                    Args.StringToBeInserted = "<TD align='center'>-</TD>"
                    Cancel = True
                Else
                    'End By VarunA on 18-Aug-2008 (For Whiziblesem8 Enhancement)
                    If lngLeaveStatusID = 1 Or lngLeaveStatusID = 3 Then

                    Else
                        Args.StringToBeInserted = "<TD align='center'>-</TD>"
                        Cancel = True
                    End If
                End If
            ElseIf (Args.ColumnName.ToUpper = "REJECT") Then
                'Added By VarunA on 18-Aug-2008 (For Whiziblesem8 Enhancement)
                'Purpose : No one can change leave details on inactive resources.
                If EmpStatus = True Then
                    Args.StringToBeInserted = "<TD align='center'>-</TD>"
                    Cancel = True
                Else
                    'End By VarunA on 18-Aug-2008 (For Whiziblesem8 Enhancement)
                    'Modified by ManishK on 6th Feb 06 For WhizibleSem SP 6.0 WFH Issue 
                    If lngLeaveStatusID = 3 Or lngLeaveStatusID = 4 Then
                        'If lngLeaveStatusID <> 1 Then
                        'End of Modified by ManishK on 6th Feb 06 For WhizibleSem SP 6.0 WFH Issue 
                        Args.StringToBeInserted = "<TD align='center'>-</TD>"
                        Cancel = True
                    End If
                    'Added By NitinVS on 14 May 2007 for WhizibleSEM 7.0 for Performace 
                    ' Removed the Conditional clause for the link and added the condition in code.
                End If
            ElseIf (Args.ColumnName.ToUpper = "VIEW COMMENTS") Then
                    If lngLeaveStatusID <> 2 And lngLeaveStatusID <> 3 Then
                        Args.StringToBeInserted = "<TD align='center'>-</TD>"
                        Cancel = True
                    End If
                    ' End Addition BY NitinVS on 14 May 2007 for WhizibleSEM 7.0 for Performace 

            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                Cancel = True

                'ADDED AND DELETED BY AMIT MAHADIK ON 19,20 MAY 2011,WHIZIBLESEM 10.0
                ''''''ElseIf Args.ColumnName.ToUpper = "LEAVE TYPE" Then

                ''''''    Dim strisHalfDay As String
                ''''''    Args.StringToBeInserted = "<TD align='left'>" + Args.DataReader.Item("LeaveType") + strisHalfDay + "</TD>"

                ''''''    Cancel = True
                'ADDED AND DELETED BY AMIT MAHADIK ON 19,20 MAY 2011,WHIZIBLESEM 10.0
                End If
            Else
            End If
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

        'Addition made by SuchitraP on 7-MAY-2007 for Cleanup Activity
        'Purpose:To apply default sort order on status i.e Submitted leaves should be shown first
        Args.GridSQL = Args.GridSQL.Replace("ORDER BY", "ORDER BY LeaveStatus DESC,")
        'End of Addition by SuchitraP on 7-MAY-2007 for Cleanup Activity
        MyBase.Initialize_Grid(Cancel, Args, WhizGlobal)

    End Sub

End Class

