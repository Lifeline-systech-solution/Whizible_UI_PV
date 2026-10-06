
Imports CommonFunctions
Imports CommonFunctions.General
Imports System.Web.HttpUtility

Public Class DocumentReview_ShowHistory
    Inherits WebPages.Template.WhizTemplate
#Region "Global Variables"
    Protected m_blnAddAccess As Boolean
    Protected m_blnDelAccess As Boolean
    Protected m_strProjectID As String
    Protected m_strDocumentID As String
    Protected m_strDocumentType As String
    Protected m_strWindowTitle As String
    Protected m_strAction As String
    Protected m_strMode As String
    Protected CONST_MODE_HISTORY As String = "HISTORY"
    Protected CONST_ACTION_DELETE As String = "DELETE"
    Protected m_strMasterTagID As String = "3721"
    Protected m_intProjectDocumentReftypeid As Integer
    Protected intProjectRequirementID As Integer
    Private m_strProjectCode As String
    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid
#End Region
  

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = "Document History"

    End Sub
    Public Sub PageInit()


        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccess As WebPage.Templates.AccessRights
        Dim objDrProject As IDataReader

        'initialize the resource file for Documents
        MyBase.InitializeResources("AppResources.RM_Documents", "AppResources")

        m_intProjectDocumentReftypeid = CInt(Request.QueryString("ProjectDocumentReftypeid"))
        intProjectRequirementID = CInt(HttpContext.Current.Request.QueryString("ProjectRequirementID"))
        m_strMode = Request.QueryString("Mode") + ""

        m_strDocumentType = CStr(Request.QueryString("DocumentType"))

        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strSQL = "Select DocumentID from tbl_RM_ProjectReqDocument Where ProjectDocumentRefTypeId=" + m_intProjectDocumentReftypeid.ToString
        strSQL = "usp_sel_tbl_RM_ProjectReqDocument_DocumentID_New " + m_intProjectDocumentReftypeid.ToString
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        objDR = Data.GetDataReader(strSQL, True)
        If objDR.Read Then
            m_strDocumentID = CStr(objDR.Item("DocumentID"))
        End If
        CommonFunctions.Data.DisposeDataReader(objDR)


        'get the access settings for the user
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject
        objAccess = New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add
        m_blnDelAccess = objAccess.Delete
        'blnEditAccess = objAccess.Edit
        objAccess = Nothing
        'm_strProjectID = CStr(Session("intProjectID"))
        m_strProjectID = Request.QueryString("ProjectID")
        If Request.Form("hidProjectID") <> "" Then
            m_strProjectID = Request.Form("hidProjectID")
        End If
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")

        'get the project code to create the directory of name project code
        strSQL = "usp_Sel_tbl_PM_Project " + m_strProjectID.ToString
        objDrProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDrProject.Read Then
            m_strProjectCode = CommonFunctions.Data.CheckIsDBNull(objDrProject("ProjectCode"), "").ToString + ""
        End If
        CommonFunctions.Data.DisposeDataReader(objDrProject)

        m_strProjectCode = Replace(m_strProjectCode, "\", "_")
        m_strProjectCode = Replace(m_strProjectCode, "/", "_")


        m_strAction = Request.QueryString("Action") + ""

        Select Case m_strMode.ToUpper.Trim
            Case CONST_MODE_HISTORY

                If m_strAction <> "" Then
                    Call performAction()
                    ' Added By NitinVS on 18 March 2005 for PBNITE SP2
                    ' Call RefreshParent()
                    ' End Addition By NitinVS on 18 March 2005 for PBNITE SP2 SP2
                End If


                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                If m_blnDelAccess = True Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_DELETE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_DELETE")) : arrClientSideFunctions.Add("Delete_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP")) : arrClientSideFunctions.Add("Help_OnClick('" + m_strMasterTagID.Trim + "')")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for issue assignment page.
                '   MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_HISTORY") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen for document history
                Call plotDocumentHistoryScreen()

                'plot the lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

        End Select

    End Sub
    '=====================================================================
    ' Procedure Name		:	plotDocumentHistoryScreen
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls to show the history records  of the document
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	ChristinaT
    ' Created				:	4 Jan 2007

    '=====================================================================
    Private Sub plotDocumentHistoryScreen()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim objFile As CommonFunction.FileDirectory
        Dim objLink As WebPage.UI.cDynamicLink
        Dim strFileName As String
        Dim strDocumentType As String
        Dim strTRClass As String
        Dim intRowCount As Integer
        Dim strFilePath As String
        Dim blnFileExists As Boolean


        Dim drcomments As IDataReader



        'get document type from the database
        strDocumentType = ""
        If m_strDocumentID <> "" Then
            strSQL = "usp_sel_tbl_RM_GetHistory " + m_strDocumentID.Trim + "," + m_strProjectID.Trim + "," + m_intProjectDocumentReftypeid.ToString + "," + intProjectRequirementID.ToString
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                strDocumentType = Data.CheckIsDBNull(objDr("ReferenceType"), "").ToString + ""
            Else
                strDocumentType = ""
            End If


            'display document type
            General.WriteHTML("<Table width=99.9% class='clsTable' cellpadding=0 cellspacing=0 >")
            General.WriteHTML("<TR class='clsTRSectionHeader'>")
            General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("LBL_DOCUMENTTYPE") + ": </B> ")
            General.WriteHTML(strDocumentType.Trim + "</TD>")
            General.WriteHTML("</TR></Table><BR>")

            'get the data for each document history record
            intRowCount = 0
            objFile = New CommonFunction.FileDirectory
            objLink = New WebPage.UI.cDynamicLink
            objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
            objLink.ReturnHTML = True
            'General.WriteHTML("<div id='DivList" + intRowCount.ToString + "' width=100% height=100% style='overflow: auto;'>")
            General.WriteHTML("<div id='DivList" + "' width=100% height=100% style='overflow:SCROLL;'>")
            '   General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

            

            While strDocumentType <> ""


                strTRClass = "clsTREven"
                'display the grid for document history details

                General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")


                strFilePath = Server.MapPath("../../Requirement Management/" + m_strProjectCode + "/") + Data.CheckIsDBNull(objDr("DirectoryName"), "").ToString + "\" + Data.CheckIsDBNull(objDr("FileName"), "").ToString
                If objFile.IsFileExists(strFilePath.Trim) = True Then
                    blnFileExists = True
                Else
                    blnFileExists = False
                End If

                'display file name
                General.WriteHTML("<TR class='clsTRSectionHeader' >")
                General.WriteHTML("<TD width=25% align='right' ><B>" + MyBase.GetResourceString("LBL_FILENAME") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left'>" + Data.CheckIsDBNull(objDr("FileName"), "").ToString + "</TD>")

                'if file exists then show the download link
                If blnFileExists = True Then
                    objLink.LinkName = MyBase.GetResourceString("LINK_DOWNLOAD") + ""

                    'objLink.FunctionName = "Download_OnClick(" + m_intProjectDocumentReftypeid.ToString + ")"
                    objLink.FunctionName = "Download_OnClick(" + objDr("ProjectDocumentReftypeid").ToString + ")"

                    objLink.Tooltip = MyBase.GetResourceString("LINK_DOWNLOAD") + ""
                    General.WriteHTML("<TD></TD><TD align='right'> " + objLink.GetDynamicLink() + " </TD>")
                Else
                    General.WriteHTML("<TD></TD><TD></TD>")
                End If
                General.WriteHTML("</TR>")

                'show uploaded by and file size
                General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("LBL_UPLOADDATE") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left'>" + Dates.GetDate(CType(Data.CheckIsDBNull(objDr("UploadedDate"), ""), Date)) + "</TD>")
                If blnFileExists = True Then
                    General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("LBL_FILESIZE") + "</B>&nbsp;</TD>")
                    General.WriteHTML("<TD align='left'>" + Data.CheckIsDBNull(objDr("FileSize"), "").ToString + " " + MyBase.GetResourceString("KB") + "</TD>")
                Else
                    General.WriteHTML("<TD></TD><TD></TD>")
                End If
                General.WriteHTML("</TR>")

                'display Last modified
                General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("LBL_LASTMODIFIED") + "</B>&nbsp;</TD>")

                'General.WriteHTML("<TD align='left' colspan=3>" + Dates.GetDate(CType(Data.CheckIsDBNull(objDr("UpdatedDate"), ""), Date)) + "</TD>")
                Dim strDate As String
                If CStr(CommonFunctions.Data.CheckIsDBNull(objDr("UpdatedDate"), "")) = "" Then
                    strDate = ""
                Else
                    strDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(objDr("UpdatedDate"), "").ToString))
                End If
                General.WriteHTML("<TD align='left' colspan=3>" + strDate + "</TD>")
                'End
                General.WriteHTML("</TR>")

                'display Description
                General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                General.WriteHTML("<TD align='right' valign='top'><B>" + MyBase.GetResourceString("LBL_DESCRIPTION") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left' colspan=3>" + Data.CheckIsDBNull(objDr("Description"), "").ToString + "</TD>")
                General.WriteHTML("</TR>")

                'display uploaded by
                General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("LBL_UPLOADEDBY") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left' colspan=3>" + Data.CheckIsDBNull(objDr("UploadedBy"), "").ToString + "</TD>")
                General.WriteHTML("</TR>")


                'if user has delete access then show the delete checkbox column
                If m_blnDelAccess = True Then
                    If Not IsDBNull(objDr("DocumentRefTypeID")) Then
                        General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                        General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("LBL_DELETE") + "</B>&nbsp;</TD>")
                        General.WriteHTML("<TD align='left' colspan=3>")
                        General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , CStr(objDr("ProjectDocumentRefTypeID")), , , True))
                        General.WriteHTML("</TD></TR>")
                    End If
                End If

                'plot the grid for previous comments
                Dim arrColHeader() As String = {"Reviewed By", "Reviewed Date", "Comments"}
                Dim arrAN() As String = {"ReviewedBy", "ReviewDate", "Comments"}


                ''create Grid object and set the properties
                m_objGrid = New WebPage.Templates.GenericGrid

                'Plot the grid
                'Plot the column headers
                General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("LBL_REVIEWDETAILS") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left' colspan=3></TD>")
                General.WriteHTML("</TR>")

                General.WriteHTML("<TR class='clsTRSectionHeader' >")
                General.WriteHTML("<TD align='left' width='15%'><B>" + MyBase.GetResourceString("LBL_REVIEWEDBY") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left' width='25%'><B>" + MyBase.GetResourceString("LBL_REVIEWEDDATE") + "</B>&nbsp;&nbsp;&nbsp;</TD>")
                General.WriteHTML("<TD align='left' width='60%'><B>" + MyBase.GetResourceString("LBL_COMMENTS") + "</B></TD>")
                ' General.WriteHTML("<TD align='left'><B>Comments </B>&nbsp;</TD>")
                General.WriteHTML("<TD></TD>")
                General.WriteHTML("</TR>")

                'create the SP for grid data without sorting 
                strSQL = "Exec usp_Sel_RM_ProjectDocument_ReviewComments " + CStr(objDr("ProjectDocumentRefTypeID"))
                drcomments = Data.GetDataReader(strSQL, True)
                While drcomments.Read
                    General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                    General.WriteHTML("<TD align='left' width='15%'>" + CStr(drcomments.Item("ReviewedBy")) + "&nbsp;</TD>")
                    General.WriteHTML("<TD align='left' width='25%'>" + CStr(drcomments.Item("ReviewDate")) + "&nbsp;&nbsp;&nbsp;</TD>")
                    General.WriteHTML("<TD align='left' width='60%'>" + CStr(drcomments.Item("Comments")) + "</TD>")
                    General.WriteHTML("<TD></TD>")
                    General.WriteHTML("</TR>")
                End While
                Data.DisposeDataReader(drcomments)

                General.WriteHTML("</Table>")
                General.WriteHTML("<BR><BR>")
                

                If Not objDr.Read() Then
                    Exit While
                End If


                'increament the row conter
                intRowCount += 1
            End While
            Data.DisposeDataReader(objDr)
            ''close the body Div
            ' General.WriteHTML("</Table>")
            General.WriteHTML("</Div>")
            objLink = Nothing
            objFile = Nothing
        End If
        'if no rows printed then display message 
        If intRowCount < 1 Then
            'display the grid for document history details
            General.WriteHTML("<div id='DivList' width=100% height=90% style='overflow: auto;'>")
            General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='center' colspan=4 >")
            General.WriteHTML(MyBase.GetResourceString("LBL_NO_RECORD_FOUND"))
            General.WriteHTML("</TD></TR>")

            General.WriteHTML("</Table>")
            General.WriteHTML("</Div>")
        End If

       
        'save the record count in the hidden control
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txthdRowCount", "txthdRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
       
    End Sub
   

    '=====================================================================
    ' Procedure Name		:	performAction
    ' Parameters Passed		:   none
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database based on the action specified.
    ' Description			:	Here document record is deleted for the selected documents from the database.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	ChristinaT
    ' Created				:	4 Jan 2007

    '=====================================================================
    Private Sub performAction()
        Dim strSQL As String
        Dim strDocumentIDList As String
        Dim arrDocumentID() As String
        Dim objDr As IDataReader
        Dim objFile As CommonFunction.FileDirectory
        Dim strFilePath As String
        Dim objDrProject As IDataReader


        'get the comma seperated list of selected document IDs
        strDocumentIDList = HttpContext.Current.Request.Form("chkdelete") + ""


        Select Case m_strAction
            Case CONST_ACTION_DELETE
                If strDocumentIDList <> "" Then
                    objFile = New CommonFunction.FileDirectory

                    arrDocumentID = Split(strDocumentIDList, ",")

                    

                    Dim i As Integer
                    For i = 0 To arrDocumentID.Length - 1

                        strSQL = "usp_sel_tbl_RM_FilesForDeletion  " + m_strDocumentID.Trim + "," + m_strProjectID.Trim + "," + arrDocumentID(i).Trim
                        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        While objDr.Read
                            strSQL = "usp_Del_tbl_RM_ProjectDocuments " + objDr("ProjectDocumentRefTypeID").ToString + ""
                            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                            
                            ' delete the physical file also
                            If CommonFunction.Application.PhysicalDeletionOfDocuments = True Then
                                strFilePath = "../../Requirement Management/" + m_strProjectCode + "/" + Data.CheckIsDBNull(objDr("DirectoryName"), "").ToString + "/" + Data.CheckIsDBNull(objDr("FileName"), "").ToString
                                strFilePath = Server.MapPath(strFilePath)
                                objFile.DeleteFile(strFilePath.Trim)
                            End If


                        End While
                        Data.DisposeDataReader(objDr)

                    Next
                    objFile = Nothing
                End If
        End Select

    End Sub
End Class
