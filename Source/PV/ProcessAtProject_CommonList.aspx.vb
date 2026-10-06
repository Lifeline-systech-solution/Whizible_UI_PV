Imports CommonEngines.General.cEventHandlers
'Code Added by SwatiC on 6 Jun 2007 For IssueID : 12859
Imports WebPages.Security
'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12859
Public Class ProcessAtProject_CommonList
    Inherits CommonList

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitPlotGrid()

        InitializeComponent()
    End Sub

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) 'Handles MyBase.Load
        MyBase.strListPage = "ProcessAtProject_CommonList.aspx"
        MyBase.strFormPage = "ProcessAtProject_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub

#End Region

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If HttpContext.Current.Request.QueryString("ToDo") = "Sync" Then

            Dim strProcessIDs As String
            Dim strSQLQuery As String = ""
            strProcessIDs = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

            'If strProcessIDs <> "" Then
            'strSQLQuery = "EXEC usp_GetLatest_tbl_PRS_Project_SDLC_Details " & HttpContext.Current.Session("intProjectID").ToString & ",'" & strProcessIDs & "'"
            'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            'strSQLQuery = "EXEC usp_GetLatest_tbl_PRS_Project_SDLC_Details " & HttpContext.Current.Session("intProjectID").ToString & "," & HttpContext.Current.Request.QueryString("ProcessID")
            'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            Dim strScript As String = ""
            strScript = vbCrLf + "<Script language=javascript>"
            strScript += vbCrLf + "window.open('../General/Navigation.aspx?subPage=../PV/ProcessAtProject_CommonList.aspx&FromWhere=PM&MasterTagID=2132','_top');"
            'strScript += vbCrLf + "window.location.href='../PM/ProcessAtProject_CommonList.aspx?FromWhere=PM&MasterTagID=2132','_top';"
            strScript += vbCrLf + "</Script>"
            CommonFunction.General.WriteHTML(strScript)

            'End If
            'End of Addition    :   ManishK     on 29th Aug 2005

            'Added by MrugajaB on 18th Jan 2005
            'Purpose : This code will be used for refreshing tree
            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            'Added By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
            'CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'P',null,null,null," + CType(HttpContext.Current.Session("intProjectID"), String))
            'End Of Modifications - IssueID : 672

            'End OF Addition By NileshD on 13 Sep 2005 REQID - WAF3_PB_8

            'End Addition
            'Added by ManishK on 31st Aug 05
        ElseIf HttpContext.Current.Request.QueryString("ToDo") = "DelPractice" Then
            Dim strProcessIDs As String
            Dim strSQLQuery As String = ""
            strProcessIDs = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ChkDelPractice"), ""), String)

            If strProcessIDs <> "" Then
                'strSQLQuery = "EXEC usp_Del_Process_At_Project " & CType(HttpContext.Current.Session("intProjectID"), String) & ", '" & strProcessIDs & "'"
                'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Dim strScript As String = ""
                strScript = vbCrLf + "<Script language=javascript>"
                strScript += vbCrLf + "window.open('../General/Navigation.aspx?subPage=../PV/ProcessAtProject_CommonList.aspx&FromWhere=PM&MasterTagID=2132','_top');"
                'strScript += vbCrLf + "window.location.href='../PM/ProcessAtProject_CommonList.aspx?FromWhere=PM&MasterTagID=2132','_top';"
                strScript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strScript)
            End If

            'Added by MrugajaB on 18th Jan 2005
            'Purpose : This code will be used for refreshing tree
            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            'Added By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
            'CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'P',null,null,null," + CType(HttpContext.Current.Session("intProjectID"), String))
            'End Of Modifications - IssueID : 672

            'End OF Addition By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
        End If
        'End of Addition    :   ManishK     on 31st Aug 2005

    End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "DELPRACTICE_ONCLICK" Then
            Dim strFunction As String
            strFunction = "var objForm;" + vbCrLf
            strFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            strFunction += "objRef = GetObjectReference('frmCommonList','chkDelPractice',true);" + vbCrLf
            strFunction += "var i;" + vbCrLf
            strFunction += "for(i=0 ; i<objRef.length;i++ ){" + vbCrLf
            strFunction += "if(objRef[i].checked==true){" + vbCrLf
            'Modified by MrugajaB on Date 3rd July 2006 for WhizibleSEM Issue ID.4168
            strFunction += " var Result=confirm('Process(es) will be deleted from Project,changed data for that Process(es) will be lost.\nDo you want to delete?')" + vbCrLf
            strFunction += "if(Result==true)" + vbCrLf
            'strFunction += "if(confirm('Process(es) will be deleted from Project,changed data for that Process(es) will be lost.\nDo you want to delete?')==true)" + vbCrLf
            'End Modification
            strFunction += "{" + vbCrLf
            strFunction += "objForm.action = '../PV/ProcessAtProject_CommonList.aspx?FromWhere=PM&MasterTagId=2132" + "&ToDo=DelPractice'" + vbCrLf
            strFunction += "objForm.submit();" + vbCrLf
            strFunction += "return;}}} " + vbCrLf
            strFunction += "return;"
            Args.ToBeInsertedInFunction = strFunction
        End If

        'end of addition by ManishK on 31st Aug 05
        'End Integration
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cProcessAtProject_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29
        'Code Added     :   ManishK     on 29th Aug 2005
        'If Args.ClientSideFunctionName.ToUpper = "SYNCPROCESSES" Then

        If Args.ClientSideFunctionName.ToUpper = "GETLATEST_ONCLICK" Then
            Dim strFunction As String
            strFunction = "var objForm; var objRef;" + vbCrLf
            strFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            strFunction += "objRef = GetObjectReference('frmCommonList','chkDelete',true);" + vbCrLf

            'strFunction += "var i;" + vbCrLf
            'strFunction += "for(i=0 ; i<objRef.length;i++ ){" + vbCrLf
            'strFunction += "if(objRef[i].checked==true){" + vbCrLf
            strFunction += "if(confirm('Process(es) marked as RED will be deleted from Project and for Process(es) marked as BLUE,\nlatest data will be taken from Corporate Level.\nDo you want to continue?')==true)" + vbCrLf
            strFunction += "{" + vbCrLf

            strFunction += "objForm.action = '../PV/ProcessAtProject_CommonList.aspx?FromWhere=PM&MasterTagId=2132&ProcessID=' + lngUniqueID + '&ToDo=Sync'" + vbCrLf
            strFunction += "objForm.submit();" + vbCrLf
            'strFunction += "return;}}}" + vbCrLf
            strFunction += "return;}" + vbCrLf

            strFunction += "return;"

            Args.ToBeInserted = strFunction
        End If
        'End of Addition   ManishK     on 29th Aug 2005

    End Sub

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cProcessAtProject_CommonListSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Args.HTMLLegend = ""
    End Sub

    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        If HttpContext.Current.Request.QueryString("ToDo") = "Sync" Then

            Dim strProcessIDs As String
            Dim strSQLQuery As String = ""
            strProcessIDs = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

            'If strProcessIDs <> "" Then
            'strSQLQuery = "EXEC usp_GetLatest_tbl_PRS_Project_SDLC_Details " & HttpContext.Current.Session("intProjectID").ToString & ",'" & strProcessIDs & "'"
            'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            strSQLQuery = "EXEC usp_GetLatest_tbl_PRS_Project_SDLC_Details " & HttpContext.Current.Session("intProjectID").ToString & "," & HttpContext.Current.Request.QueryString("ProcessID")
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            'Dim strScript As String = ""
            'strScript = vbCrLf + "<Script language=javascript>"
            'strScript += vbCrLf + "window.open('../General/Navigation.aspx?subPage=../PV/ProcessAtProject_CommonList.aspx&FromWhere=PM&MasterTagID=2132','_top');"
            ''strScript += vbCrLf + "window.location.href='../PM/ProcessAtProject_CommonList.aspx?FromWhere=PM&MasterTagID=2132','_top';"
            'strScript += vbCrLf + "</Script>"
            'CommonFunction.General.WriteHTML(strScript)

            'End If
            'End of Addition    :   ManishK     on 29th Aug 2005

            'Added by MrugajaB on 18th Jan 2005
            'Purpose : This code will be used for refreshing tree
            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            'Added By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'P',null,null,null," + CType(HttpContext.Current.Session("intProjectID"), String))
            'End Of Modifications - IssueID : 672

            'End OF Addition By NileshD on 13 Sep 2005 REQID - WAF3_PB_8

            'End Addition
            'Added by ManishK on 31st Aug 05
        ElseIf HttpContext.Current.Request.QueryString("ToDo") = "DelPractice" Then
            Dim strProcessIDs As String
            Dim strSQLQuery As String = ""
            strProcessIDs = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ChkDelPractice"), ""), String)

            If strProcessIDs <> "" Then
                strSQLQuery = "EXEC usp_Del_Process_At_Project " & CType(HttpContext.Current.Session("intProjectID"), String) & ", '" & strProcessIDs & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'Dim strScript As String = ""
                'strScript = vbCrLf + "<Script language=javascript>"
                'strScript += vbCrLf + "window.open('../General/Navigation.aspx?subPage=../PV/ProcessAtProject_CommonList.aspx&FromWhere=PM&MasterTagID=2132','_top');"
                ''strScript += vbCrLf + "window.location.href='../PM/ProcessAtProject_CommonList.aspx?FromWhere=PM&MasterTagID=2132','_top';"
                'strScript += vbCrLf + "</Script>"
                'CommonFunction.General.WriteHTML(strScript)
            End If

            'Added by MrugajaB on 18th Jan 2005
            'Purpose : This code will be used for refreshing tree
            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            'Added By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'P',null,null,null," + CType(HttpContext.Current.Session("intProjectID"), String))
            'End Of Modifications - IssueID : 672

            'End OF Addition By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
        End If
        'End of Addition    :   ManishK     on 31st Aug 2005
    End Sub
End Class

Public Class cProcessAtProject_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strSQL As String
        Dim drProjectType As IDataReader
        Dim intProjectTypeID As Integer
        Dim strFilter As String

        strSQL = "EXEC usp_Sel_ProjectType 1," + HttpContext.Current.Session("intProjectID").ToString
        drProjectType = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drProjectType.Read Then
            intProjectTypeID = CInt(drProjectType("ProjectTypeID"))
        End If

        If intProjectTypeID <> 0 Then
            GetPageSpecificFilters = " AND ProjectID= " + HttpContext.Current.Session("intProjectID").ToString + " AND ProjectTypeID= " + intProjectTypeID.ToString
        End If
        CommonFunction.Data.DisposeDataReader(drProjectType)
    End Function
End Class

Public Class cProcessAtProject_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strSQLQuery As String
        Dim drProcess As IDataReader
        'Code added by SwatiC on 6 Jun 2007 For IssueID : 12859
        Dim m_objAccessRights As cAccessRights
        m_objAccessRights = New WebPages.Security.cAccessRights(WhizGlobal)
        m_objAccessRights.GetAccess()
        'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12859

        'Code Added :   ManishK on 29th Dec 2005
        'Purpose    :   To change the caption of Delete to Is Selected
        If Args.DataReader("IsSelected").ToString = "Yes" And Args.DataReader("IsRemoved").ToString = "No" Then
            Args.IsSelected = False
            Args.IsCheckBoxDisabled = True

        End If

        If Args.ColumnName.ToUpper = "PROCESS NAME" Then
            Args.EnableLink = False
        End If
        'End Of Addition    :  ManishK on 29th Aug 2005
        'Added By ManishK on 31th Aug 05

        Dim strActivityID As String = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProcessID")).ToString

        'If Args.ColumnName.ToUpper = "DELETE PROCESS" Then
        If Args.ColumnName.ToUpper = "DELETE" Then
            'Added By ManishK on 2nd Sep 05 to disabled the SELECT checkbox 
            Dim objIsExists As IDataReader
            Dim blnUseSQL As Boolean
            Dim strSQL As String
            blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

            'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29
            'Code Added By SantoshK on 2sep 2005
            'If Practice Exists on Project Then Enable it otherwise disable it
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            ' strSQL = "SELECT ProcessID FROM tbl_PRS_Project_SDLC_ProcessDetails WHERE ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String) + " AND ProcessID = " + Args.DataReader("ProcessID").ToString
            strSQL = "usp_sel_ProcessID_tbl_PRS_Project_SDLC_ProcessDetails " + CType(HttpContext.Current.Session("intProjectID"), String) + "," + Args.DataReader("ProcessID").ToString
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            'Addition Ends 2 Sep 2005
            objIsExists = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
            If objIsExists.Read Then
                Args.StringToBeInserted = "<TD align=Center><Input Type=checkbox id='chkDelPractice' name='chkDelPractice' class='clsCheckBox' value='" & strActivityID & "'></td>"
                Cancel = True
            Else
                Args.StringToBeInserted = "<TD align=Center><Input Type=checkbox id='chkDelPractice' name='chkDelPractice' class='clsCheckBox' value='" & strActivityID & "' disabled></td>"
                Cancel = True
            End If
            CommonFunction.Data.DisposeDataReader(objIsExists)

        ElseIf Args.ColumnName.ToUpper = "GET LATEST REVISION" Then
            If Args.DataReader("ProcessID").ToString <> "" Then
                strSQLQuery = "Exec usp_sel_Process_Revision  " + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProcessID"), "0"), String) & "," & HttpContext.Current.Session("intProjectID").ToString
                drProcess = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drProcess.Read Then
                    If CType(CommonFunction.Data.CheckIsDBNull(drProcess("IsRevised"), "0"), Long) = 0 Then
                        Args.IgnoreActualValue = True
                        Args.EnableLink = False
                        Args.ReplacementValue = "<FONT color='BLACK'>" + "Latest" + "</FONT>"
                        'Code Commented and added by SwatiC on 6 Jun 2007 For IssueID : 12859
                        'End If
                    ElseIf CType(CommonFunction.Data.CheckIsDBNull(drProcess("IsRevised"), "0"), Long) = 1 Then

                        If Not (m_objAccessRights.Edit) Then
                            Args.IgnoreActualValue = True
                            Args.EnableLink = False
                            Args.ReplacementValue = "<FONT color='BLUE'>" + "Get Latest Revision" + "</FONT>"
                        End If
                    End If
                    'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12859
                End If
                CommonFunction.Data.DisposeDataReader(drProcess)
            End If
        End If
        'Code added by SwatiC on 6 Jun 2007 For IssueID : 12859
        m_objAccessRights = Nothing
        'End of Code addition by SwatiC on 6 Jun 2007 For IssueID : 12859

        'End of Addition By ManishK on 31th Aug 05
        'End Integration
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Code Added :   ManishK on 29th Aug 2005
        'Purpose    :   To make the DELETE Column as Synchronize

        'If Args.ColumnName.ToUpper = "DELETE" Then
        'Args.ColumnName = "Synchronize"
        'End If

        Select Case Args.DataField.ToUpper
            Case "CHKDELPRACTICE"
                Args.ApplySorting = False
        End Select


        'End Of Addition    : ManishK on 29th Aug 2005
    End Sub
End Class


