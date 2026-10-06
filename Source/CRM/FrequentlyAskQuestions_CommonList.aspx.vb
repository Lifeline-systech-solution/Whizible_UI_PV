Imports CommonEngines.General.cEventHandlers
Imports System.Text
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports System.IO
''********************************************************************************
''THIS PAGE INTEGRATED BY AMIT MAHADIK FOR WHIZIBLESEM 10.0 ON 19 AUGUST 2011
''********************************************************************************

Public Class FrequentlyAskQuestions_CommonList
    Inherits CommonList
    Private m_blnFaqAccess As WebPages.Security.cAccessRights
    Private mfaq_objGlobal As WebPages.Template.IGlobal

    'Public m_PKToken As String


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
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "FrequentlyAskQuestions_CommonList.aspx"
        MyBase.strFormPage = "FrequentlyAskQuestions_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"

        'Dim faqobjGlobal As WebPages.Template.IGlobal
        'Dim faqobjAccessRights As WebPages.Security.cAccessRights
        'MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)


        'faqobjGlobal = MyBase.GlobalObject()

        'faqobjAccessRights = New WebPages.Security.cAccessRights(faqobjGlobal)
        ''faqobjAccessRights.GetAccess()

        'faqobjAccessRights.View = True

        'faqobjAccessRights.RoleLevel = 0
        'faqobjGlobal.TagID = 8036


        'MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        'faqobjGlobal = MyBase.GlobalObject()
        'faqobjGlobal.RoleLevel = 1
        'faqobjGlobal.TagID = 8036
        'faqobjGlobal.UserID = 61
        'faqobjGlobal.RoleID = 7

        'faqobjAccessRights = New WebPages.Security.cAccessRights(faqobjGlobal)
        'faqobjAccessRights.GetAccess()


        'Added by Pramod
        If (Request.QueryString("Flag")) = "SAVE" Then
            addDiscussion()
        End If
        'Ended by Pramod D
        'added By MAdnar N
        'If Not Page.IsPostBack Then
        ' If HttpContext.Current.Request.QueryString("FromWhere") <> Nothing Then
        'CommonFunctions.HTMLControls.DrawTextBox("TempFromWhere", "TempFromWhere", "clsTextBox", 0, 0, HttpContext.Current.Request.QueryString("FromWhere").ToString, , , , , , True, HttpContext.Current.Request.QueryString("FromWhere").ToString, True)
        'End If
        'End If
        'End By Madnar
        MyBase.Page_Load(sender, e)
    End Sub
    'Added by Pramod D..On 7/7/2011
    'Purpose: Conversion from FAQ to Discussion
    Private Sub addDiscussion()
        ' Dim strPath As String = Server.MapPath("../../Attachments/CRM/")
        Dim UserName As String = ""
        Dim RequiredIdArray As String = ""
        Dim QueryIDD As String = ""
        Dim sqlstr As String
        Dim creader As IDataReader
        UserName = Session("strUserName").ToString
        Dim File1 As String
        Dim File2 As String
        Dim TempPkToken As String = ""
        Dim FromWhere As String = ""
        ''Get data form
        'UserName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form())
        'Comments = CommonFunction.General.CheckIsNothing(HttpContext.Current.re)
        RequiredIdArray = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
        QueryIDD = HttpContext.Current.Request.QueryString("QueryID")
        FromWhere = Request.Form("FromWhere")
        TempPkToken = CommonFunctions.Security.Token.GetToken(CType(QueryIDD, String) + CType(Session("intUserID"), String) + "0" + "0")
        ' UserName = HttpContext.Current.Request.QueryString("UserName")
        Dim strQuery As String = ""
        Dim strQueryB As String = ""
        Dim ConversionFD As IDataReader
        Dim selectedID() As String
        selectedID = RequiredIdArray.Split(CChar(","))
        Dim i As Integer
        'Dim fso As Scripting.FileSystemObject = CreateObject("Scripting.FileSystemObject")

        ' Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
        'Modified By Mandar N
        For i = 0 To selectedID.Length - 1
            ' INSERT INTO tbl_CRM_Query_Details AND tbl_CRM_Attachments TABLE
            ''Modified by NitinC on 27 April 2012 for WhizibleSEM 11.0 [Issue Fix : After live page crash for convert to faq. added single quote for username]
            strQuery = "EXEC usp_Upd_faq_to_discussion_CRM_faq " + selectedID(i) & ",'" & UserName & "'," & QueryIDD
            CommonFunction.Data.InsertOrUpdateData(strQuery, True)
            sqlstr = "EXEC usp_Sel_FaqAttachments " & selectedID(i) & ""
            creader = CommonFunctions.Data.GetDataReader(sqlstr, True)
            While creader.Read()
                '  Try
                File1 = "../../Attachments/FAQ/" & creader("OriginalFileName").ToString & " "
                File2 = "../../Attachments/CRM/" & creader("OriginalFileName").ToString & " "
                File1 = HttpContext.Current.Server.MapPath(File1)
                File2 = HttpContext.Current.Server.MapPath(File2)
                CommonFunctions.FileDirectory.CopyFile(File1, File2, True)


                'FileSystem.FileCopy("../../Attachments/FAQ/8705aab0.sql", "../../Attachments/CRM/")
                'FileSystem.FileCopy(File1, File2)


                ' Catch
                '  Console.WriteLine("Double copying is not allowed, which was not expected.")
                ' End Try
                'Dim objFile As New FileUpload.cUpload(, creader("OriginalFileName").ToString, strPath, strFileName)
                'objFile.UploadFile()
            End While
        Next



        'Dim objFile As New FileUpload.cUpload("txtFileName", strPath, strFileName)
        'objFile.OverwriteIfExists = True
        'objFile.UploadFile()
        'End Of Modification By Mandar N
        'Added By Mandar N 
        ' CommonFunction.General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','../Source/CRM/CRM_DiscussionThread.aspx');")
        'Dim Refreshpath As String
        'Dim TempQueryID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("QueryID"), "")
        'Dim TempToken As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("PKToken"), "")
        'Dim TempCnt As Integer
        'Dim TempChengedPath As String

        'Refreshpath = Request.Url.PathAndQuery

        'TempChengedPath = Refreshpath.Replace("Flag=SAVE&", "")
        '' Dim TempPath() As String = Refreshpath.Split(CChar("?"))
        '' Dim TempPath2() As String = TempPath(2).Split(CChar("&"))
        'TempToken = Request.Url.Query

        'TempQueryID = Request.Url.AbsolutePath
        ' For TempCnt = 1 To TempPath.Length

        'CommonFunction.General.WriteHTML("<Script language=javascript>")
        'CommonFunction.General.WriteHTML("window.opener.location.reload()")
        ' CommonFunction.General.WriteHTML("alert( '" & TempPath(TempCnt).ToString & "' )")
        'CommonFunction.General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','../Source/CRM/CRM_DiscussionThread.aspx');")
        'CommonFunction.General.WriteHTML("alert( '" & TempToken.ToString & "' )")
        'CommonFunction.General.WriteHTML("alert( '" & Refreshpath.ToString & "' )")
        'CommonFunction.General.WriteHTML("alert( '" & TempQueryID.ToString & "' )")
        'CommonFunction.General.WriteHTML("alert( '" & TempChengedPath.ToString & "' )")
        'CommonFunction.General.WriteHTML(" window.opener.location.replace('" & TempChengedPath.ToString & "');")
        'CommonFunction.General.WriteHTML("window.close();window.opener.location.reload();")
        'CommonFunction.General.WriteHTML("</SCRIPT>")


        'Next
        'End By Mandar N

        CommonFunction.General.WriteHTML("<Script language=javascript>")
        CommonFunction.General.WriteHTML(" window.close();")
        CommonFunction.General.WriteHTML("window.opener.location.href= '../CRM/CRM_DiscussionThread.aspx?FromWhere=" & FromWhere & "&ConvertFlag=Convert&RequiredFaqId=" & RequiredIdArray.ToString & "&QueryID=" & QueryIDD.ToString & "&PKToken=" & TempPkToken.ToString & "  ' ")
        'CommonFunction.General.WriteHTML("alert( '" & Refreshpath.ToString & "' )")
        'CommonFunction.General.WriteHTML(" window.close();")
        CommonFunction.General.WriteHTML("</SCRIPT>")
    End Sub
    'Ended by Pramod D

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added By Mandar N ON 01-july-2011 
        ' Notes 
        Dim StrSql As String
        Dim StatusFlag As String

        Dim strFromWhere As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("isMaster"), "")
        If strFromWhere.ToUpper() = "YES" Then
            If (Args.LinkName.ToUpper = "ADD TO DISCUSSION COMMENTS") Then
                Args.DisplayPosition = ""
            End If

        End If
        If strFromWhere = "YES?SetFilter=1" Then
            If (Args.LinkName.ToUpper = "ADD TO DISCUSSION COMMENTS") Then
                Args.DisplayPosition = ""
            End If
        End If
        'Added By Syamantak Chavan On 31-August-2011
        Dim strFrom As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")
        If strFrom.ToUpper() = "SM" Then
            If (Args.LinkName.ToUpper = "ADD TO DISCUSSION COMMENTS") Then
                Args.DisplayPosition = ""
            End If

        End If
        'End Addition By Syamantak Chavan On 31-August-2011
        If HttpContext.Current.Request.QueryString("Mode") = "RO" Then
            If ((HttpContext.Current.Request.QueryString("Mode") = "RO")) Then ' Or (HttpContext.Current.Request.QueryString("Mode") = "" And HttpContext.Current.Request.QueryString("SetFilter") = "1")) Then
                Args.DisplayPosition = ""
                ' If Args.LinkName.ToUpper = "FILTERS" Then
                ' Args.DisplayPosition = "LIST_HEAD"
                ' Args.ToBeInsertedInFunction = "objfrm.action = 'FrequentlyAskQuestions_CommonList.aspx?SetFilter=1&Mode=RO'"
                'Args.ToBeInserted = "objfrm.action = 'FrequentlyAskQuestions_CommonList.aspx?SetFilter=1&Mode=RO;return;'"
                'Args.ToBeInserted = "FrequentlyAskQuestions_CommonList.aspx?&SetFilter=1&Mode=RO&QueryID=NULL&DepartmentName=&MasterTagID=20004&DeptFlag=SR ";objfrm.submit();return;"
                ' End If
                ' If Args.LinkName = "&nbsp;?&nbsp;" Then
                '    Args.DisplayPosition = "LIST_HEAD"
                'End If



                If Not CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("QueryID"), "").ToString = "NULL" Then
                    StrSql = "Usp_Sel_QueryMasterStatus_Faq " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("QueryID"))
                    StatusFlag = CommonFunctions.Data.GetDataScalar(StrSql, True).ToString
                    If (Args.LinkName.ToUpper = "ADD TO DISCUSSION COMMENTS") Then
                        'If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "AR" Or CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "DB" Or CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "SR" Or CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "MD" Then
                        '   
                        'End If 
                        Args.DisplayPosition = "LIST_HEAD"
                        If StatusFlag = "2" Then
                            Args.DisplayPosition = ""
                        End If
                       
                    End If
                End If
                ' If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PKToken")).ToString <> "" Then
                '            If (Args.LinkName.ToUpper = "CONVERT TO DISCUSSION") Then
                '                Args.DisplayPosition = "LIST_HEAD"
                '            End If
                '            ' Else
                '            '  If (Args.LinkName.ToUpper = "CONVERT TO DISCUSSION") Then
                '            ' Args.DisplayPosition = ""
                '            'End If

                '        End If

                '    End If
                'End If
            End If

        End If
       
        If (Args.LinkName.ToUpper = "CLOSE") Then
            If HttpContext.Current.Request.QueryString("Mode") = Nothing Then

                Args.DisplayPosition = ""
            End If
        End If

        '   If Args.ClientSideFunctionName.ToString.ToUpper = "CTD" Then

        'Args.ToBeInsertedInFunction = "../Sierra/FrequentlyAskQuestions_CommonList.aspx?Flag=SAVE&Mode=RO&FromWhere=" & Request.QueryString("FromWhere") & "&QueryID=" & Request.QueryString("QueryID") & ";objfrm.submit();return; "
        '   End If
        '  End of Addition By Mandar N


    End Sub

    Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)
        ' If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString = "RO" Then
        ' ToBeInsertedInFunction += "&Mode=RO"
        'ToBeInsertedInFunction += "objfrm.action = ""FrequentlyAskQuestions_CommonList.aspx?&SetFilter=1&Mode=RO&MasterTagID=20004&QueryID=NULL"";objfrm.submit();return;"
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode")).ToString = "RO" And CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("QueryID")) = "NULL" Then
            ToBeInsertedInFunction += "objfrm.action = ""FrequentlyAskQuestions_CommonList.aspx?&SetFilter=1&Mode=RO&QueryID=NULL&DepartmentName=" & HttpContext.Current.Request.QueryString("DepartmentName") & "&MasterTagID=9017&DeptFlag=" & HttpContext.Current.Request.QueryString("DeptFlag") & " "";objfrm.submit();return;"
        ElseIf CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode")).ToString = "RO" And CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("QueryID")) <> "NULL" Then
            ToBeInsertedInFunction += "objfrm.action = ""FrequentlyAskQuestions_CommonList.aspx?&SetFilter=1&FromWhere=" & HttpContext.Current.Request.QueryString("FromWhere") & "&Mode=RO&QueryID=" & HttpContext.Current.Request.QueryString("QueryID") & "&DepartmentName=" & HttpContext.Current.Request.QueryString("DepartmentName") & "&MasterTagID=9017&DeptFlag=" & HttpContext.Current.Request.QueryString("DeptFlag") & " "";objfrm.submit();return;"
            ' ToBeInsertedInFunction += "objfrm.action = ""FrequentlyAskQuestions_CommonList.aspx?&SetFilter=1&MasterTagID=20004"";objfrm.submit();return;"
        End If



    End Sub


    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'If Args.ClientSideFunctionName.ToUpper = "SETFILTER" Then

    End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
    'Added By Mandar N on 30-jun-2011 For changing Column header
    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New Faq_DynamicFilters(m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New FAQ_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        'Put user code to initialize the page here
        Return New Faq_PlotGrid(MyBase.m_objGlobal)
    End Function
    'End Of addition by Mandar N

End Class

Public Class Faq_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public m_lngEmployeeID As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added By mandar N for changing Column header

        If Args.DataField.ToUpper = "IMAGE1" Then
            Args.ApplySorting = False
            Args.ColumnName = "<IMG border=0 src='../../Images/pin.gif'>"
            Args.ApplyHTMLEncode = False
        End If
        If Args.DataField.ToUpper = "IMAGE2" Then
            Args.ApplySorting = False
            Args.ColumnName = "<IMG border=0 src='../../Images/Discussions.gif'>"
            Args.ApplyHTMLEncode = False
        End If

        If Args.DataField.ToUpper = "ATTACHMENTS" Then
            Args.ApplySorting = False
            Args.ColumnName = "<IMG border=0 src='../../Images/pin.gif'>"
            Args.ApplyHTMLEncode = False
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then


            If (HttpContext.Current.Request.QueryString("Mode") = "RO" And (HttpContext.Current.Request.QueryString("QueryID") = "NULL" Or HttpContext.Current.Request.QueryString("QueryID") = Nothing)) Then
                Cancel = True
            ElseIf (HttpContext.Current.Request.QueryString("FromWhere") = Nothing And HttpContext.Current.Request.QueryString("Mode") <> Nothing) Then
                Cancel = True
                ' ElseIf (HttpContext.Current.Request.QueryString("Mode") = "RO" And (HttpContext.Current.Request.QueryString("FromWhere") <> "DB" And HttpContext.Current.Request.QueryString("FromWhere") <> "AR")) Then
                '    Cancel = True
            Else
                Args.ColumnName = "Select"
            End If
            If HttpContext.Current.Request.QueryString("Mode") = Nothing Then
                Args.ColumnName = "Delete"
            End If

        ElseIf HttpContext.Current.Request.QueryString("Mode") = "RO" And (HttpContext.Current.Request.QueryString("QueryID") <> "NULL" Or HttpContext.Current.Request.QueryString("QueryID") <> Nothing) Then



        Else
            '  If (HttpContext.Current.Request.QueryString("FromWhere") = "DB" Or HttpContext.Current.Request.QueryString("FromWhere") = "AR") Then
            ' Args.ColumnName = "Select"
            'End If

            '    If (HttpContext.Current.Request.QueryString("MasterTagId") = "20004") Then

            '    ElseIf (HttpContext.Current.Request.QueryString("Mode") = "RO" And HttpContext.Current.Request.QueryString("QueryID") = "NULL" Or HttpContext.Current.Request.QueryString("QueryID") = Nothing) Then
            '        Cancel = True
            '    ElseIf HttpContext.Current.Request.QueryString("QueryID") <> "NULL" Or HttpContext.Current.Request.QueryString("QueryID") <> Nothing Then
            '        Args.ColumnName = "Select"

            '    Else
        End If

        ' End If

        'If (HttpContext.Current.Request.QueryString("SetFilter") = "1") Then

        'End If






        'If (HttpContext.Current.Request.QueryString("Mode") = "RO") Then
        '    If Args.ColumnName.ToUpper = "DELETE" Then
        '        Cancel = True

        '    End If
        ' End If

        'End Of Addition By mandar N
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added By Mandar N ON 01-july-2011

        Dim m_PKToken As String
        m_lngEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("empid"), "")


        If (HttpContext.Current.Request.QueryString("Mode") = "RO") Then

            If Args.DataField.ToUpper = "FAQCODE" Then
                ''TO REMOVE LINK ADDED BY AMIT MAHADIK FOR WHIZIBLESEM 10.0 ON 19 AUGUST 2011
                Args.StringToBeInserted = "<TD>" & HttpUtility.HtmlEncode((CType(Args.DataReader("FaqCode"), String))) & "</TD>"
                Cancel = True
            End If
            If Args.DataField.ToUpper = "SUBJECT" Then

                If Trim(Args.DataReader("Subject").ToString & "") <> "" Then

                    If Len(Trim(Args.DataReader("Subject").ToString & "")) > 50 Then
                        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("FaqID"), String) + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), ""), String) + CType(0, String) + CType(20004, String))
                        'Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding
                        'Args.StringToBeInserted = "<TD vAlign=top Title=" & Chr(34) & (HttpUtility.HtmlEncode(Args.DataReader("Subject").ToString)) & Chr(34) & " style='width=25%' nowrap;><PRE>"
                        Args.StringToBeInserted = "<TD vAlign=top Title=" & Chr(34) & (Args.DataReader("Subject").ToString) & Chr(34) & " style='width=25%' nowrap;><PRE>"
                        'End Of Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding

                        'Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding
                        'Args.StringToBeInserted = Args.StringToBeInserted & (Left(Trim(HttpUtility.HtmlEncode(Args.DataReader("Subject").ToString) & ""), 50)) & "...</PRE></TD>"
                        Args.StringToBeInserted = Args.StringToBeInserted & (Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "...</PRE></TD>"
                        'End Of Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding

                        Args.ApplyHTMLEncode = False
                        Cancel = True
                    Else
                        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("FaqID"), String) + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), ""), String) + CType(0, String) + CType(20004, String))
                        'Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding
                        'Args.StringToBeInserted = "<TD vAlign=top Title=" & Chr(34) & Web.HttpContext.Current.Server.HtmlEncode(HttpUtility.HtmlEncode(Args.DataReader("Subject").ToString)) & Chr(34) & " style='width=25%' nowrap;><PRE>"
                        Args.StringToBeInserted = "<TD vAlign=top Title=" & Chr(34) & HttpUtility.HtmlEncode(Args.DataReader("Subject").ToString) & Chr(34) & " style='width=25%' nowrap;><PRE>"
                        'End Of Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding

                        'Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding
                        'Args.StringToBeInserted = Args.StringToBeInserted & Web.HttpContext.Current.Server.HtmlEncode(Trim(HttpUtility.HtmlEncode(Args.DataReader("Subject").ToString))) & "</PRE></TD>"
                        Args.StringToBeInserted = Args.StringToBeInserted & Trim(HttpUtility.HtmlEncode(Args.DataReader("Subject").ToString)) & "</PRE></TD>"
                        'End Of Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding

                        Cancel = True
                    End If
                End If

            End If

            If Args.ColumnName.ToUpper = "DELETE" Then

            End If
            If Args.ColumnName.ToUpper = "DELETE" Then
                If (HttpContext.Current.Request.QueryString("Mode") = "RO" And HttpContext.Current.Request.QueryString("QueryID") = "NULL" Or HttpContext.Current.Request.QueryString("QueryID") = Nothing) Then
                    Cancel = True
                ElseIf (HttpContext.Current.Request.QueryString("FromWhere") = Nothing) Then
                    Cancel = True
                Else
                    '  If (HttpContext.Current.Request.QueryString("Mode") = "RO" And (HttpContext.Current.Request.QueryString("FromWhere") <> "DB" And HttpContext.Current.Request.QueryString("FromWhere") <> "AR")) Then
                    'Cancel = True
                    'End If
                End If
            Else
            End If
            'If Args.ColumnName.ToUpper = "DELETE" Then
            '    Cancel = True

            'End If
        End If
        'Added by Pramod D,,,,On 14/08/2011
        If (HttpContext.Current.Request.QueryString("Mode") <> "RO") Then
            If Args.DataField.ToUpper = "SUBJECT" Then
                Args.StringToBeInserted = "<TD><PRE>" & (CType(HttpUtility.HtmlEncode(Args.DataReader("Subject")), String)) & "</PRE></TD>"
                Cancel = True
            End If
        End If
        'End of Addition




        'If Args.DataField.ToUpper = "IMAGE1" Then

        '    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        '    Args.ApplyHTMLEncode = False
        '    ''Args.TDStyle = " title='Attachments' "
        '    If Trim(Args.DataReader("Attachments").ToString & "") <> "" Then
        '        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("FaqID"), String) + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), ""), String) + CType(0, String) + CType(8036, String))
        '        '' Args.StringToBeInserted = "<TD  NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "'  style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
        '        Args.StringToBeInserted = "<TD vAlign=top title='Attachments' style='TEXT_DECORATION:None' nowrap;>" _
        '                    & "<A href=""JavaScript:Document_OnClick('" & CType(Args.DataReader("FaqID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "')"">" & Trim(Args.DataReader("Attachments").ToString & "") & "</A></TD>"

        '        Cancel = True
        '    ElseIf (CInt(Args.DataReader("Attachments")).Equals(0)) Then
        '        Args.DataField = " "

        'Else
        '        Args.DataField = " "
        '    End If
        'End If

        If Args.DataField.ToUpper = "ATTACHMENTS" Then

            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
            Args.ApplyHTMLEncode = False
            ''Args.TDStyle = " title='Attachments' "
            If Trim(Args.DataReader("Attachments").ToString & "") <> "" And (CInt(Args.DataReader("Attachments")) <> 0) Then
                m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("FaqID"), String) + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), ""), String) + CType(0, String) + CType(20004, String))
                '' Args.StringToBeInserted = "<TD  NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "'  style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                Args.StringToBeInserted = "<TD vAlign=top title='Attachments' style='TEXT_DECORATION:None' nowrap;><PRE>" _
                            & "<A href=""JavaScript:Document_OnClick('" & CType(Args.DataReader("FaqID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "')"">" & "&nbsp;<IMG border=0 src='../../Images/pin.gif'>" & Trim(Args.DataReader("Attachments").ToString & "") & "</A></PRE></TD>"

                Cancel = True
            ElseIf (CInt(Args.DataReader("Attachments")).Equals(0)) Then
                Args.IgnoreActualValue = True
                Args.StringToBeInserted = ""
                Args.ReplacementValue = ""

                'ElseIf (CInt(Args.DataReader("Attachments")) = 0) Then
                '    Args.StringToBeInserted = ""
            Else
                Args.StringToBeInserted = ""
            End If
        End If

        '  If HttpContext.Current.Request.QueryString("MasterTagID") = "20004" Then
        'Added by Pramod D...On 17/08/2011

        If Args.DataField.ToUpper = "DESCRIPTION" Then
            ' Cancel = True

            '   CommonFunctions.General.WriteHTML("<td><pre> ")
            '  Args.ReplacementValue = ("Description").ToString()
            ''Commented and added by NitinC on 16 April 2012 For WhizibleSEM 11.0 [Issue Fix : 61407 did not check null value hence page was crashed.]
            'Args.StringToBeInserted = "<TD><PRE>" & (CType(Args.DataReader("Description"), String)) & "</PRE></TD>"
            Args.StringToBeInserted = "<TD><PRE>" & CType(CommonFunction.Data.CheckIsDBNull(HttpUtility.HtmlEncode(Args.DataReader("Description")), ""), String) & "</PRE></TD>"
            ''End of Commented and added by NitinC on 16 April 2012 For WhizibleSEM 11.0 [Issue Fix : 61407 did not check null value hence page was crashed.]
            Cancel = True

            ' CommonFunctions.General.WriteHTML("</pre></td>)")
        End If

        'End of Addition

        ' End If

        'End Of addition By Mandar N
    End Sub

End Class

Public Class Faq_DynamicFilters

    Inherits CommonEngine.CommonList.cDynamicFilters

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Dim sbscript As New StringBuilder

        ' If (HttpContext.Current.Request.QueryString("eid") <> "") Then
        If (HttpContext.Current.Request.QueryString("DeptFlag") = "SR") Then

        Else

            If (Args.FilterName = "DepartmentName") Then
                '   Dim StrSql As String
                ' Dim Dr As IDataReader
                ' Dim Dept As String
                ' Dim sbscript As New StringBuilder
                Dim deptName As String
                deptName = HttpContext.Current.Request.QueryString("DepartmentName")
                'StrSql = "usp_Sel_getDepartmentName " + HttpContext.Current.Request.QueryString("eid") + ""
                ' Dept = CType(CommonFunction.Data.GetDataScalar(StrSql, True), String)

                ' Args.FixedValue = HttpContext.Current.Request.QueryString("DepartmentName")
                If (HttpContext.Current.Request.QueryString("DepartmentName") <> "") Then
                    'CommonFunctions.General.WriteHTML("<td>")
                    'Cancel = True
                    'Args.ControlWidth = 0
                    ' CommonFunctions.General.WriteHTML("<TD>")
                    Args.FilterCaption = " <b>Department:</b></TD>" & "<TD>" & HttpContext.Current.Request.QueryString("DepartmentName") & "</TD>"

                    'CommonFunctions.General.WriteHTML(HttpContext.Current.Request.QueryString("DepartmentName"))
                    'CommonFunctions.General.WriteHTML("</TD>")
                    'Args.SQL = "usp_Sel_getDepartmentName " + HttpContext.Current.Request.QueryString("eid") + ""
                    ' Args.ToBeInserted = HttpContext.Current.Request.QueryString("DepartmentName")

                    ' Args.ToBeInsertedInControl = HttpContext.Current.Request.QueryString("DepartmentName")
                    'CommonFunctions.General.WriteHTML("<Script languague= 'javascript'>")
                    'CommonFunctions.General.WriteHTML("document.getElementById('Department').disabled=true;")
                    'CommonFunctions.General.WriteHTML("</Script>")
                    Args.DisplayNone = True

                    'CommonFunctions.General.WriteHTML("</td>")
                    'Args.UserFriendlyFixedValue = HttpContext.Current.Request.QueryString("DepartmentName")
                    ' Args.FixedValue = HttpContext.Current.Request.QueryString("DepartmentName")
                    ' Args.ToBeInsertedInControl = ""


                    'Args.FixedValue = HttpContext.Current.Request.QueryString("DepartmentName")
                    'Args.ControlWidth = 0
                    ' Args.UserFriendlyFixedValue = HttpContext.Current.Request.QueryString("DepartmentName")
                    'Args.ToBeInserted = HttpContext.Current.Request.QueryString("DepartmentName")
                    'Args.UserFriendlyFixedValue = HttpContext.Current.Request.QueryString("DepartmentName")
                End If
                '  Args.UserFriendlyFixedValue = HttpContext.Current.Request.QueryString("DepartmentName")


                'If (Args.FunctionName.ToUpper = "SETFILTER") Then
                '    '    Args.ToBeInserted = "objfrm.action = ""FrequentlyAskQuestions_CommonList.aspx?&SetFilter=1&Mode=RO"";objfrm.submit();return;"
                '    'End If

                '    'Args.DisplayNone = False
                '    sbscript.Append("<Script language=javascript>" + vbCrLf)
                '    sbscript.Append("objfrm.action = ""FrequentlyAskQuestions_CommonList.aspx?&SetFilter=1&Mode=RO"";")
                '    sbscript.Append("</Script>")
                'End If
                '    sbscript.Append("<td>")
                '   
                '    sbscript.Append("function setFilter(){" + vbCrLf)
                '    sbscript.Append("objfrm.action = ""FrequentlyAskQuestions_CommonList.aspx?SetFilter=1&Mode=RO"";objfrm.submit();" + vbCrLf)
                '    sbscript.Append("}" + vbCrLf)
                '    sbscript.Append("</Script>")
                '    sbscript.Append("</td>")
                '    'insert the newly generated script to th

            End If
            'Args.ToBeInserted = sbscript.ToString
        End If
        'End If

    End Sub

End Class

Class FAQ_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'If (CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DepartmentName"), "")) Then
        'If (CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeptFlag"), "") = "SR") Then
        'Dim dept As String

        If (CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DepartmentName"), "") = "") Then
        Else
            ' dept = (HttpContext.Current.Request.QueryString("DepartmentName").Replace("%20", " "))
            Args.WhereClause += " AND Status = 1 AND DepartmentName Like '" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DepartmentName")) + "'"
        End If
        If (HttpContext.Current.Request.QueryString("MasterTagId") = "20004") Then
            Args.WhereClause += "AND Status = 1"
        End If
        'If (HttpContext.Current.Request.QueryString("SetFilter") = "1") And HttpContext.Current.Request.QueryString("Mode") = "RO" Then
        ' Args.WhereClause += "AND Status = 1"
        ' End If


        ' End If

        ' End If
    End Sub

    'Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
    '    GetPageSpecificFilters += "DepartmentName Like '%IS%' "
    'End Function
End Class

