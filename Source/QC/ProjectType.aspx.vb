
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Data.SqlClient



Partial Public Class ProjectType
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Form Actions"
    Private Const ACTION_CREATE_TEMPLATE As String = "Create Template"
#End Region

#Region "Private Variables"
    Private objSTBuilder As System.Text.StringBuilder = Nothing
    Private strProjectTypeID As String
    Private strMode As String
    Private intPosition As Integer

#End Region

#Region "All Constants use in ProjectType Definition"
    Private Const PROJECT_TYPE_PHASE As String = "Phases"
    Private Const PROJECT_TYPE_TASKTYPE As String = "Task Types"
    Private Const PROJECT_TYPE_ISSUETYPE As String = "Issue Types"
    Private Const PROJECT_TYPE_REVIEWTYPES As String = "Review Types"
    Private Const PROJECT_TYPE_CORPORATERISKS As String = "Corporate Risks"
    Private Const PROJECT_TYPE_PROCESSES As String = "Configure Processes"
    Private Const PROJECT_TYPE_METRICS As String = "Configure Metrics"

#End Region

#Region "Descriptive part of each item"
    Private Const PROJECT_TYPE_PHASE_DES As String = "Select the phases that belong to this Project Type"
    Private Const PROJECT_TYPE_TASKTYPE_DES As String = "Select the Task types you want to configure for this Project Type."
    Private Const PROJECT_TYPE_ISSUETYPE_DES As String = "Select Issue types which are applicable for selected Project type."
    Private Const PROJECT_TYPE_REVIEWTYPES_DES As String = "Select Review types which are applicable for selected Project type."
    Private Const PROJECT_TYPE_CORPORATERISKS_DES As String = "Select Corporate Risks which are applicable for selected Project type."
    Private Const PROJECT_TYPE_PROCESSES_DES As String = "Select the Processes and there activities for this project Type "
    Private Const PROJECT_TYPE_METRICS_DES As String = "Select the Metrics which are applicable for this project Type "

#End Region



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        'if (Request.QueryString["PKID"] != null)
        strProjectTypeID = Request.QueryString("TypeID")

        'strProjectTypeID = "1";
        strMode = Request("List21")

        'if(strMode = "Save")
        '{
        'Save the record in respective tables
        '1) Store project type name and description.
        '    Response.Write (Request.QueryString("List21"));
        '}
        objSTBuilder = New System.Text.StringBuilder()

        ' Display different sections for the Project types.
        objSTBuilder.Append("<Form id=form1 action='projectType.aspx?Mode=SAVE'>")
        objSTBuilder.Append("<div id='divmain' style='height:100%;width:100%;overflow:auto'>")
        objSTBuilder.Append("<table  style='width: 100%;' align='Center'>")
        objSTBuilder.Append("   <tr>")
        objSTBuilder.Append(" <TD colspan=5 align=right>")
        objSTBuilder.Append("      <input type='submit' name='save' value='Save' id='save' class='pwa-ButtonHeightWidth2' />&nbsp;&nbsp")
        objSTBuilder.Append("      <input type='submit' name='cancel' value='Close' id='cancel' class='pwa-ButtonHeightWidth2' onclick='javascript:closewindow()'/>")
        objSTBuilder.Append("   </TD>")
        objSTBuilder.Append(" </TR>")
        objSTBuilder.Append("</table><BR>")

        ' Display Name and Description of a Project Type.
        ShowProjectTypeInformation(strProjectTypeID)
        ' Display all phases associated with the current project type.
        intPosition = 1
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        ' Dim strsourceSQL As String = "Select PhaseId,Phase From tbl_IB_Phases where phaseId not in (Select PhaseId from tbl_PRS_ProjectType_Phases where ProjectTypeId =" + strProjectTypeID + ")"
        Dim strsourceSQL As String = "usp_sel_tbl_PRS_ProjectType_Phases " + strProjectTypeID
        'Dim strDestSQL As String = "SELECT tbl_IB_Phases.PhaseId,Phase FROM tbl_PRS_ProjectType_Phases ,tbl_IB_Phases where ProjectTypeId = " + strProjectTypeID + " AND tbl_PRS_ProjectType_Phases.phaseId = tbl_IB_Phases.PhaseId"
        Dim strDestSQL As String = "usp_sel_IB_tbl_PRS_ProjectType_Phases " + strProjectTypeID

        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        CreateHTMLforSectionListBox(strProjectTypeID, PROJECT_TYPE_PHASE, PROJECT_TYPE_PHASE_DES, strsourceSQL, strDestSQL)
        ' Display all Task types associated with the current project type.
        intPosition = 2
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'strsourceSQL = "Select TasktypeId,Tasktype From tbl_PM_TaskTypes where TasktypeId not in (Select TaskTypeId from tbl_PM_ProjectTypes_TaskTypes where ProjectTypeId = " + strProjectTypeID + ")"
        strsourceSQL = "usp_sel_tbl_PM_ProjectTypes_TaskTypes " + strProjectTypeID
        'strDestSQL = "select tbl_PM_TaskTypes.TasktypeId,Tasktype from tbl_PM_ProjectTypes_TaskTypes,tbl_PM_TaskTypes where tbl_PM_ProjectTypes_TaskTypes.TasktypeId = tbl_PM_TaskTypes.TasktypeId And ProjectTypeId = " + strProjectTypeID
        strDestSQL = "usp_sel_TaskTypes_tbl_PM_ProjectTypes_TaskTypes " + strProjectTypeID

        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        CreateHTMLforSectionListBox(strProjectTypeID, PROJECT_TYPE_TASKTYPE, PROJECT_TYPE_TASKTYPE_DES, strsourceSQL, strDestSQL)
        ' Display all Issue types associated with the current project type.
        intPosition = 3
        strsourceSQL = "usp_sel_GetIssueTypes " + strProjectTypeID
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'strDestSQL = "Select TypeID,Type FROM tbl_IB_Type where TypeID IN (Select TypeID FROM tbl_PM_ProjectTypes_IssueTypes where ProjectTypeID= " + strProjectTypeID + ")"
        strDestSQL = "usp_sel_tbl_PM_ProjectTypes_IssuePM " + strProjectTypeID
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        CreateHTMLforSectionListBox(strProjectTypeID, PROJECT_TYPE_ISSUETYPE, PROJECT_TYPE_ISSUETYPE_DES, strsourceSQL, strDestSQL)
        ' Display all Review types associated with the current project type.
        intPosition = 4
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'strsourceSQL = " SELECT Distinct CReviewTypeID,CReviewType FROM tbl_PM_CorporateReviewTypes  INNER JOIN tbl_PM_ProjectTypes_TaskTypes ON    tbl_PM_CorporateReviewTypes.TaskTypeID = tbl_PM_ProjectTypes_TaskTypes.TaskTypeID   AND tbl_PM_ProjectTypes_TaskTypes.ProjectTypeID = " + strProjectTypeID + "  AND tbl_PM_CorporateReviewTypes.CReviewTypeID NOT IN(Select CReviewTypeID FROM    tbl_PM_ProjectTypes_ReviewTypes WHERE ProjectTypeID=" + strProjectTypeID + ")"
        strsourceSQL = "usp_sel_tbl_PM_ProjectTypes_ReviewTypes_CReviewType " + strProjectTypeID
        'strDestSQL = " SELECT CReviewTypeID,CReviewType FROM tbl_PM_CorporateReviewTypes   WHERE CReviewTypeID in(Select CReviewTypeID FROM tbl_PM_ProjectTypes_ReviewTypes WHERE ProjectTypeID=" + strProjectTypeID + ")"
        strDestSQL = "usp_sel_tbl_PM_CorporateReviewTypes_CReviewType " + strProjectTypeID
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


        CreateHTMLforSectionListBox(strProjectTypeID, PROJECT_TYPE_REVIEWTYPES, PROJECT_TYPE_REVIEWTYPES_DES, strsourceSQL, strDestSQL)

        ' Display all Corporate Risks associated with the current project type.
        intPosition = 5
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'strsourceSQL = "SELECT tbl_PM_CorporateRisks.CorporateRiskID,tbl_PM_CorporateRisks.[Description] FROM tbl_PM_CorporateRisks  WHERE tbl_PM_CorporateRisks.CorporateRiskID NOT IN(Select CorporateRiskID FROM tbl_PM_ProjectType_CorporateRisk   WHERE ProjectTypeID=" + strProjectTypeID + ")"
        strsourceSQL = "usp_sel_tbl_PM_ProjectType_CorporateRisk_Risk " + strProjectTypeID
        'strDestSQL = "  SELECT tbl_PM_CorporateRisks.CorporateRiskID,tbl_PM_CorporateRisks.[Description] FROM tbl_PM_CorporateRisks   WHERE  tbl_PM_CorporateRisks.CorporateRiskID IN(Select CorporateRiskID FROM tbl_PM_ProjectType_CorporateRisk   WHERE ProjectTypeID=" + strProjectTypeID + ")"
        strDestSQL = "usp_sel_tbl_PM_CorporateRisks_NotIn " + strProjectTypeID

        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        CreateHTMLforSectionListBox(strProjectTypeID, PROJECT_TYPE_CORPORATERISKS, PROJECT_TYPE_CORPORATERISKS_DES, strsourceSQL, strDestSQL)

        'display all the processes associated with the selected project type
        intPosition = 6
        strsourceSQL = "EXEC usp_sel_GetListOfProcess " + strProjectTypeID
        CreateHTMLForMultiSelection(strProjectTypeID, PROJECT_TYPE_PROCESSES, PROJECT_TYPE_PROCESSES_DES, strsourceSQL)

        'display all the metrics associated with the selected project type
        intPosition = 7
        strsourceSQL = "EXEC usp_sel_GetListOfMetrics " + strProjectTypeID
        CreateHTMLForMultiSelectionMetrics(strProjectTypeID, PROJECT_TYPE_METRICS, PROJECT_TYPE_METRICS_DES, strsourceSQL)


        objSTBuilder.Append("</div></Form>")
        Response.Write(objSTBuilder.ToString())
    End Sub 'Page_Load




#Region "ProjectType Details"


    Private Sub CreateHTMLForMultiSelection(ByVal strProjectTypeID As String, ByVal strHeader As String, ByVal strHeaderDescription As String, ByVal strsourceSQL As String)
        ' Display process part and Metrics definition part over here.
        objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=1 width='95%' align='center' border=0>")
        objSTBuilder.Append("<TR><TD class=ms-sectionline colSpan=2 height=1></TD></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append("<TD class=ms-sectionline colSpan=2 height=1 width=40%></TD>")
        objSTBuilder.Append("</TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append("<TD class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22>")
        '    objSTBuilder.Append("<H3 class=ms-standardheader><A onclick='javascript:ShowHideSection('ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms', 'ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ImgHideShow' );return false;' href='javascript:return;'><IMG id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ImgHideShow style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' alt=Hide/Show src='1033/minus.gif' border=0>&nbsp; "  + strHeader + "</H3></A></TD>");
        objSTBuilder.Append((" <H3 class=ms-standardheader><A onclick=javascript:ShowHideSection(this,'" + intPosition + "')><IMG style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' lt=Hide/Show src='1033/minus.gif' border=0>&nbsp; " + strHeader + " </H3></A></TD>"))

        objSTBuilder.Append("<TD class=ms-authoringcontrols>&nbsp;</TD>")
        objSTBuilder.Append("</TR>")
        objSTBuilder.Append("<TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms>")
        objSTBuilder.Append(" <TD class=ms-descriptiontext vAlign=top>")
        objSTBuilder.Append("  <TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("<TBODY>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(("  <TD class='ms-descriptiontext ms-inputformdescription'>" + strHeaderDescription + "</TD>"))
        objSTBuilder.Append("  <TD><IMG height=1 alt='' src='1033/blank.gif' width=8></TD></TR>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append("<TD><IMG height=19 alt='' src='1033/blank.gif' width=150></TD></TR></TBODY></TABLE></TD>")
        objSTBuilder.Append("<TD class='ms-authoringcontrols ms-inputformcontrols' vAlign=top align=left>")
        objSTBuilder.Append(" <TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("  <TBODY>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append(" <TD width=9><IMG height=1 alt='' src='1033/blank.gif' width=9></TD>")
        objSTBuilder.Append(" <TD><IMG height=1 alt='' src='1033/blank.gif' width=150></TD>")
        objSTBuilder.Append(" <TD width=10><IMG height=1 alt='' src='1033/blank.gif' width=10></TD></TR>")
        objSTBuilder.Append(" <TR>")
        'objSTBuilder.Append("  <TD>");
        objSTBuilder.Append("  <TD class=ms-authoringcontrols width='60%'>")
        objSTBuilder.Append("   <TABLE class=ms-authoringcontrols cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("     <TBODY>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_tablerow1>")
        objSTBuilder.Append("     <TD class=ms-authoringcontrols noWrap colSpan=2><SPAN id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_LiteralLabelText></SPAN></TD></TR>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_tablerow2>")
        objSTBuilder.Append("     <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD></TR>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_tablerow3>")
        objSTBuilder.Append("     <TD width=11><IMG height=1 alt='' src='1033/blank.gif' width=11></TD>")
        objSTBuilder.Append("     <TD class=ms-authoringcontrols width='99%'>")
        objSTBuilder.Append("     <DIV id=idDivGlobals>")
        objSTBuilder.Append("     <TABLE class=ms-authoringcontrols>")
        objSTBuilder.Append("     <TBODY>")
        objSTBuilder.Append("     <TR>")
        objSTBuilder.Append("     <TD width='60%'>")




        objSTBuilder.Append(" <DIV style='BACKGROUND-COLOR: window'>")
        objSTBuilder.Append(" <TABLE class=XmlGridTable id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_idGrdGlobalPerms ")
        objSTBuilder.Append(" style='BORDER-RIGHT: #99afcb 1px solid; BORDER-TOP: #99afcb 1px solid; BEHAVIOR: url(/_layouts/PWA/Library/XMLGrid.htc); BORDER-LEFT: #99afcb 1px solid; BORDER-BOTTOM: #99afcb 1px solid; BORDER-COLLAPSE: collapse' ")
        objSTBuilder.Append(" accessKey=. cellSpacing=0 rules=all border=1 ")
        objSTBuilder.Append(" OnDataChanged='OnGlobalPermChanged()' ")
        objSTBuilder.Append(" AllowMultiSelect='False' AllowRowInsert='False' ")
        objSTBuilder.Append(" AllowRowDelete='False' SelectionType='RowOnly'>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append(" <TR class=XmlGridTitleRow style='HEIGHT: 22px'>")
        objSTBuilder.Append(" <TD style='WIDTH: 30px' noWrap ColID='ENABLED' Type='Image'><A class=XmlGridSortLink><NOBR></NOBR></A></TD>")
        objSTBuilder.Append(" <TD style='WIDTH: 100%' noWrap ColID='WSEC_FEA_ACT_NAME' Type='Text'><A class=XmlGridSortLink><NOBR>Processes<IMG src='1033/UpArrow.gif'></NOBR></A></TD>")
        objSTBuilder.Append(" <TD style='WIDTH: 55px; COLOR: navy' noWrap ColID='ALLOW' Type='Checkbox'><A class=XmlGridSortLink><NOBR>Activities</NOBR></A></TD>")
        ' objSTBuilder.Append(" <TD style='WIDTH: 55px; COLOR: navy' noWrap ColID='DENY' Type='Checkbox'><A class=XmlGridSortLink><NOBR>Mandatory</NOBR></A></TD>");
        objSTBuilder.Append(" </TR>")

        'Actual data starts from here
        ' create a connection object
        Dim conn As New SqlConnection("server=192.168.100.19;Database=ProjectServer_Whizible;UID=sa;PWD=sa")

        ' declare the SqlDataReader, which is used in
        ' both the try block and the finally block
        Dim rdr As SqlDataReader = Nothing

        ' create a command object
        Dim cmd As New SqlCommand(strsourceSQL, conn)

        Try
            ' open the connection
            conn.Open()

            ' 1.  get an instance of the SqlDataReader
            rdr = cmd.ExecuteReader()

            ' 2.  print necessary columns of each record
            Dim intProcessID As Integer = 0

            While rdr.Read()
                ' get the reults of each column
                Dim strSelect As String
                strSelect = "Checked"

                Dim intProID As Integer = CInt(rdr(0))
                Dim strProcessName As String = CStr(rdr(1))
                Dim strActID As Integer = CInt(rdr(2))
                Dim strActivityName As String = CStr(rdr(3))
                Dim intValue As String = CStr(rdr(4))

                If intValue = "0" Then
                    strSelect = ""
                End If

                If intProcessID <> intProID Then
                    objSTBuilder.Append("<TR id=GridDataRow style='BACKGROUND-COLOR: #f9f9f9' State='1' Group='0' RowID='afaa8cb3-dd91-490b-a918-70e29e0509a5'>")
                    objSTBuilder.Append(" <TD><A hideFocus style='HEIGHT: 100%' tabIndex=0></A></TD>")
                    objSTBuilder.Append((" <TD GroupDisplay='1'><A hideFocus style='HEIGHT: 100%' tabIndex=0><IMG class=XmlGridGroupIcon src='1033/whiteminus.gif'>" + strProcessName + "</A></TD>"))
                    objSTBuilder.Append((" <TD><INPUT hideFocus title='Select or clear all items in this group.' type=checkbox " + strSelect + " Group='0'></INPUT></TD>"))
                    'objSTBuilder.Append(" <TD><INPUT hideFocus title='Select or clear all items in this group.' type=checkbox Group='0'></INPUT></TD>");
                    objSTBuilder.Append(" </TR>")

                    objSTBuilder.Append("<TR id=GridDataRow RowID='ab7015f0-e63d-4b9b-838d-c5284a9f99c9'>")
                    objSTBuilder.Append(" <TD><A hideFocus style='HEIGHT: 100%' tabIndex=0></A></TD>")
                    objSTBuilder.Append((" <TD><A hideFocus style='PADDING-LEFT: 30px; HEIGHT: 100%' tabIndex=0>" + strActivityName + "</A></TD>"))
                    objSTBuilder.Append(("<TD style='PADDING-LEFT: 30px'><INPUT hideFocus " + strSelect + " type=checkbox></INPUT></TD>"))
                    'objSTBuilder.Append("<TD style='PADDING-LEFT: 30px'><INPUT hideFocus type=checkbox></INPUT></TD>");
                    objSTBuilder.Append("</TR>")

                    intProcessID = intProID
                Else
                    objSTBuilder.Append("<TR id=GridDataRow RowID='ab7015f0-e63d-4b9b-838d-c5284a9f99c9'>")
                    objSTBuilder.Append(" <TD><A hideFocus style='HEIGHT: 100%' tabIndex=0></A></TD>")
                    objSTBuilder.Append((" <TD><A hideFocus style='PADDING-LEFT: 30px; HEIGHT: 100%' tabIndex=0>" + strActivityName + "</A></TD>"))
                    objSTBuilder.Append(("<TD style='PADDING-LEFT: 30px'><INPUT hideFocus " + strSelect + " type=checkbox></INPUT></TD>"))
                    'objSTBuilder.Append("<TD style='PADDING-LEFT: 30px'><INPUT hideFocus type=checkbox></INPUT></TD>");
                    objSTBuilder.Append("</TR>")
                End If
            End While
        Finally
            ' 3. close the reader
            If Not (rdr Is Nothing) Then
                rdr.Close()
            End If
            ' close the connection
            If Not (conn Is Nothing) Then
                conn.Close()
            End If
        End Try





        objSTBuilder.Append("</TBODY></TABLE>")

        objSTBuilder.Append("<table  style='width: 100%;'>")
        objSTBuilder.Append("   <tr>")
        objSTBuilder.Append(" <TD>")
        objSTBuilder.Append("      <span>Create Microsoft Project Template for selected Project Type:</span>")
        objSTBuilder.Append("      <b><span id='ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01__adGroup' datasrc='#idXmlGroup' datafld='WSEC_GRP_AD_GROUP' maxlength='64'></span></b>")
        objSTBuilder.Append("   </TD>")
        objSTBuilder.Append("  </TR>")
        objSTBuilder.Append("  <TR>")
        objSTBuilder.Append("     <TD>")
        objSTBuilder.Append("      <input type='submit' name='ctl00$ctl00$PlaceHolderMain$PWA_PlaceHolderMain$idFormSectionDetails$ctl01$_findADGroup' value='Create Template' onclick='' id='ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01__findADGroup' class='pwa-ButtonHeightWidth2' />")
        objSTBuilder.Append("   </TD>")
        objSTBuilder.Append(" </TR>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append("    <TD>")

        objSTBuilder.Append("</TD>")
        objSTBuilder.Append(" </TR>")
        objSTBuilder.Append("</table>")




        objSTBuilder.Append("</DIV></TD></TR>")
        objSTBuilder.Append("      <TR>")
        objSTBuilder.Append("      <TD>")
        objSTBuilder.Append("  </TD></TR></TBODY></TABLE></DIV></TD></TR>")
        objSTBuilder.Append("            <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_tablerow5>")
        objSTBuilder.Append("             <TD><IMG height=6 alt='' src='1033/blank.gif' width=1></TD></TR></TBODY></TABLE></TD>")
        objSTBuilder.Append("         <TD width=10><IMG height=1 alt='' src='1033/blank.gif' width=10></TD></TR>")
        objSTBuilder.Append("       <TR>")
        objSTBuilder.Append("         <TD>")
        objSTBuilder.Append(" <TD><IMG height=13 alt='' src='1033/blank.gif' width=150></TD>")
        objSTBuilder.Append(" <TD></TD></TR></TBODY></TABLE></TD></TR>")
        objSTBuilder.Append("</TABLE>")
    End Sub 'CreateHTMLForMultiSelection


    Private Sub CreateHTMLForMultiSelectionMetrics(ByVal strProjectTypeID As String, ByVal strHeader As String, ByVal strHeaderDescription As String, ByVal strsourceSQL As String)
        ' Display metriccs part and Metrics definition part over here.
        objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=1 width='95%' align='center' border=0>")
        objSTBuilder.Append("<TR><TD class=ms-sectionline colSpan=2 height=1></TD></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append("<TD class=ms-sectionline colSpan=2 height=1 width=40%></TD>")
        objSTBuilder.Append("</TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append("<TD class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22>")

        ' objSTBuilder.Append("<H3 class=ms-standardheader><A onclick='javascript:ShowHideSection(this, '" + intPosition + "' );return false;' href='javascript:return;'><IMG id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ImgHideShow style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' alt=Hide/Show src='1033/minus.gif' border=0>&nbsp; " + strHeader + "</H3></A></TD>");
        objSTBuilder.Append((" <H3 class=ms-standardheader><A onclick=javascript:ShowHideSection(this,'" + intPosition + "')><IMG style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' lt=Hide/Show src='1033/minus.gif' border=0>&nbsp; " + strHeader + " </H3></A></TD>"))

        objSTBuilder.Append("<TD class=ms-authoringcontrols>&nbsp;</TD>")
        objSTBuilder.Append("</TR>")
        objSTBuilder.Append(("<TR id=" + intPosition + ">"))
        objSTBuilder.Append(" <TD class=ms-descriptiontext vAlign=top>")
        objSTBuilder.Append("  <TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("<TBODY>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(("  <TD class='ms-descriptiontext ms-inputformdescription'>" + strHeaderDescription + "</TD>"))
        objSTBuilder.Append("  <TD><IMG height=1 alt='' src='1033/blank.gif' width=8></TD></TR>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append("<TD><IMG height=19 alt='' src='1033/blank.gif' width=150></TD></TR></TBODY></TABLE></TD>")
        objSTBuilder.Append("<TD class='ms-authoringcontrols ms-inputformcontrols' vAlign=top align=left>")
        objSTBuilder.Append(" <TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("  <TBODY>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append(" <TD width=9><IMG height=1 alt='' src='1033/blank.gif' width=9></TD>")
        objSTBuilder.Append(" <TD><IMG height=1 alt='' src='1033/blank.gif' width=150></TD>")
        objSTBuilder.Append(" <TD width=10><IMG height=1 alt='' src='1033/blank.gif' width=10></TD></TR>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append("  <TD>")
        objSTBuilder.Append("  <TD class=ms-authoringcontrols>")
        objSTBuilder.Append("   <TABLE class=ms-authoringcontrols cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("     <TBODY>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_tablerow1>")
        objSTBuilder.Append("     <TD class=ms-authoringcontrols noWrap colSpan=2><SPAN id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_LiteralLabelText></SPAN></TD></TR>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_tablerow2>")
        objSTBuilder.Append("     <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD></TR>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_tablerow3>")
        objSTBuilder.Append("     <TD width=11><IMG height=1 alt='' src='1033/blank.gif' width=11></TD>")
        objSTBuilder.Append("     <TD class=ms-authoringcontrols width='99%'>")
        objSTBuilder.Append("     <DIV id=idDivGlobals>")
        objSTBuilder.Append("     <TABLE class=ms-authoringcontrols>")
        objSTBuilder.Append("     <TBODY>")
        objSTBuilder.Append("     <TR>")
        objSTBuilder.Append("     <TD>")




        objSTBuilder.Append(" <DIV style='BACKGROUND-COLOR: window'>")
        objSTBuilder.Append(" <TABLE class=XmlGridTable id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_idGrdGlobalPerms ")
        objSTBuilder.Append(" style='BORDER-RIGHT: #99afcb 1px solid; BORDER-TOP: #99afcb 1px solid; BEHAVIOR: url(/_layouts/PWA/Library/XMLGrid.htc); BORDER-LEFT: #99afcb 1px solid; BORDER-BOTTOM: #99afcb 1px solid; BORDER-COLLAPSE: collapse' ")
        objSTBuilder.Append(" accessKey=. cellSpacing=0 rules=all border=1 ")
        objSTBuilder.Append(" OnDataChanged='OnGlobalPermChanged()' ")
        objSTBuilder.Append(" AllowMultiSelect='False' AllowRowInsert='False' ")
        objSTBuilder.Append(" AllowRowDelete='False' SelectionType='RowOnly'>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append(" <TR class=XmlGridTitleRow style='HEIGHT: 22px'>")
        objSTBuilder.Append(" <TD style='WIDTH: 30px' noWrap ColID='ENABLED' Type='Image'><A class=XmlGridSortLink><NOBR></NOBR></A></TD>")
        objSTBuilder.Append(" <TD style='WIDTH: 100%' noWrap ColID='WSEC_FEA_ACT_NAME' Type='Text'><A class=XmlGridSortLink><NOBR>Processes<IMG src='1033/UpArrow.gif'></NOBR></A></TD>")
        objSTBuilder.Append(" <TD style='WIDTH: 55px; COLOR: navy' noWrap ColID='ALLOW' Type='Checkbox'><A class=XmlGridSortLink><NOBR>Activities</NOBR></A></TD>")
        ' objSTBuilder.Append(" <TD style='WIDTH: 55px; COLOR: navy' noWrap ColID='DENY' Type='Checkbox'><A class=XmlGridSortLink><NOBR>Mandatory</NOBR></A></TD>");
        objSTBuilder.Append(" </TR>")

        'Actual data starts from here
        ' create a connection object
        Dim conn As New SqlConnection("server=192.168.100.19;Database=ProjectServer_Whizible;UID=sa;PWD=sa")

        ' declare the SqlDataReader, which is used in
        ' both the try block and the finally block
        Dim rdr As SqlDataReader = Nothing

        ' create a command object
        Dim cmd As New SqlCommand(strsourceSQL, conn)

        Try
            ' open the connection
            conn.Open()

            ' 1.  get an instance of the SqlDataReader
            rdr = cmd.ExecuteReader()

            ' 2.  print necessary columns of each record
            Dim intCategoryID As Integer = 0

            While rdr.Read()
                ' get the reults of each column
                Dim strSelect As String
                strSelect = "Checked"

                Dim intCatID As Integer = CInt(rdr(5))
                Dim strMetricName As String = CStr(rdr(1))
                Dim intMetricID As Integer = CInt(rdr(0))
                'string strBelow = (string)rdr[2];
                'string strAbove = (string)rdr[3];
                Dim strCategory As String = CStr(rdr(4))

                '  if(intValue = "0")
                '  {
                '     strSelect = "";
                '}
                If intCategoryID <> intCatID Then
                    objSTBuilder.Append("<TR id=GridDataRow style='BACKGROUND-COLOR: #f9f9f9' State='1' Group='0' RowID='afaa8cb3-dd91-490b-a918-70e29e0509a5'>")
                    objSTBuilder.Append(" <TD><A hideFocus style='HEIGHT: 100%' tabIndex=0></A></TD>")
                    objSTBuilder.Append((" <TD GroupDisplay='1'><A hideFocus style='HEIGHT: 100%' tabIndex=0><IMG class=XmlGridGroupIcon src='1033/whiteminus.gif'>" + strCategory + "</A></TD>"))
                    objSTBuilder.Append((" <TD><INPUT hideFocus title='Select or clear all items in this group.' type=checkbox " + strSelect + " Group='0'></INPUT></TD>"))
                    'objSTBuilder.Append(" <TD><INPUT hideFocus title='Select or clear all items in this group.' type=checkbox Group='0'></INPUT></TD>");
                    objSTBuilder.Append(" </TR>")

                    objSTBuilder.Append("<TR id=GridDataRow RowID='ab7015f0-e63d-4b9b-838d-c5284a9f99c9'>")
                    objSTBuilder.Append(" <TD><A hideFocus style='HEIGHT: 100%' tabIndex=0></A></TD>")
                    objSTBuilder.Append((" <TD><A hideFocus style='PADDING-LEFT: 30px; HEIGHT: 100%' tabIndex=0>" + strMetricName + "</A></TD>"))
                    objSTBuilder.Append(("<TD style='PADDING-LEFT: 30px'><INPUT hideFocus " + strSelect + " type=checkbox></INPUT></TD>"))
                    'objSTBuilder.Append("<TD style='PADDING-LEFT: 30px'><INPUT hideFocus type=checkbox></INPUT></TD>");
                    objSTBuilder.Append("</TR>")

                    intCategoryID = intCatID
                Else
                    objSTBuilder.Append("<TR id=GridDataRow RowID='ab7015f0-e63d-4b9b-838d-c5284a9f99c9'>")
                    objSTBuilder.Append(" <TD><A hideFocus style='HEIGHT: 100%' tabIndex=0></A></TD>")
                    objSTBuilder.Append((" <TD><A hideFocus style='PADDING-LEFT: 30px; HEIGHT: 100%' tabIndex=0>" + strMetricName + "</A></TD>"))
                    objSTBuilder.Append(("<TD style='PADDING-LEFT: 30px'><INPUT hideFocus " + strSelect + " type=checkbox></INPUT></TD>"))
                    'objSTBuilder.Append("<TD style='PADDING-LEFT: 30px'><INPUT hideFocus type=checkbox></INPUT></TD>");
                    objSTBuilder.Append("</TR>")
                End If
            End While
        Finally
            ' 3. close the reader
            If Not (rdr Is Nothing) Then
                rdr.Close()
            End If
            ' close the connection
            If Not (conn Is Nothing) Then
                conn.Close()
            End If
        End Try

        objSTBuilder.Append("</TBODY></TABLE>")


        objSTBuilder.Append("</DIV></TD></TR>")
        objSTBuilder.Append("      <TR>")
        objSTBuilder.Append("      <TD>")
        objSTBuilder.Append("  </TD></TR></TBODY></TABLE></DIV></TD></TR>")
        objSTBuilder.Append("            <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionGlobalPerms_ctl01_tablerow5>")
        objSTBuilder.Append("             <TD><IMG height=6 alt='' src='1033/blank.gif' width=1></TD></TR></TBODY></TABLE></TD>")
        objSTBuilder.Append("         <TD width=10><IMG height=1 alt='' src='1033/blank.gif' width=10></TD></TR>")
        objSTBuilder.Append("       <TR>")
        objSTBuilder.Append("         <TD>")
        objSTBuilder.Append(" <TD><IMG height=13 alt='' src='1033/blank.gif' width=150></TD>")
        objSTBuilder.Append(" <TD></TD></TR></TBODY></TABLE></TD></TR>")
        objSTBuilder.Append("</TABLE>")
    End Sub 'CreateHTMLForMultiSelectionMetrics



    Private Sub CreateHTMLforSectionListBox(ByVal strProjectTypeID As String, ByVal strHeader As String, ByVal strHeaderDescription As String, ByVal strsourceSQL As String, ByVal strDestSQL As String)
        objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=1 width='95%' align='center' border=0>")
        objSTBuilder.Append("<TR><TD class=ms-sectionline colSpan=2 height=1></TD></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22 width='40%'>")
        objSTBuilder.Append((" <H3 class=ms-standardheader><A onclick=javascript:ShowHideSection(this,'" + intPosition + "')><IMG style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' lt=Hide/Show src='1033/minus.gif' border=0>&nbsp; " + strHeader + " </H3></A></TD>"))
        'objSTBuilder.Append("<IMG onclick=javascript:ShowHideSection(this,'ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers') style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' alt='Hide/Show' src='1033/minus.gif' border=0>&nbsp;<H3 class=ms-standardheader>&nbsp; Phases </H3>");
        objSTBuilder.Append(" <TD class=ms-authoringcontrols>&nbsp;</TD></TR>")
        objSTBuilder.Append((" <TR id=" + intPosition + ">"))
        objSTBuilder.Append("    <TD class=ms-descriptiontext vAlign=top>")
        objSTBuilder.Append("    <TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("      <TBODY>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(("  <TD class='ms-descriptiontext ms-inputformdescription'>" + strHeaderDescription + "</TD>"))
        objSTBuilder.Append("<TD><IMG height=1 alt='' src='1033/blank.gif' width=8></TD></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD><IMG height=19 alt='' src='1033/blank.gif' width=150></TD></TR></TBODY></TABLE></TD>")

        objSTBuilder.Append("<TD class='ms-authoringcontrols ms-inputformcontrols' vAlign=top align=left>")
        objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append("  <TD>")
        objSTBuilder.Append("  <TD class=ms-authoringcontrols>")
        objSTBuilder.Append("   <TABLE class=ms-authoringcontrols cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("     <TBODY>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_tablerow1>")
        objSTBuilder.Append("     <TD class=ms-authoringcontrols noWrap colSpan=2>")
        objSTBuilder.Append("         <SPAN id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_LiteralLabelText></SPAN></TD></TR>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_tablerow2>")
        objSTBuilder.Append("     <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD></TR>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_tablerow3>")
        objSTBuilder.Append("<TD width=11><IMG height=1 alt='' src='1033/blank.gif' width=11></TD>")
        objSTBuilder.Append(" <TD class=ms-authoringcontrols width='99%'>")
        objSTBuilder.Append(" <DIV id=idDivUsers>")
        objSTBuilder.Append(" <TABLE>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append(" <TD>")
        objSTBuilder.Append(" <DIV id=idSwpUsers style='VISIBILITY: visible; BEHAVIOR: url(/_layouts/PWA/Library/ItemSwapper.htc)'>")
        objSTBuilder.Append(" <TABLE class=ms-stdtxt cellSpacing=1 cellPadding=1 border=0>")
        objSTBuilder.Append(" <COLGROUP>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColAlphaUpDown style='DISPLAY: none' span=2>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColAlphaList>")
        objSTBuilder.Append(" <COL>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColRemoveRestore>")
        objSTBuilder.Append(" <COL>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColBetaList>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColBetaUpDown style='DISPLAY: none' span=2></COLGROUP>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append(" <TH>&nbsp;</TH>")
        objSTBuilder.Append("<TH>&nbsp;</TH>")
        objSTBuilder.Append((" <TH style='VERTICAL-ALIGN: bottom'><LABEL id=idLbl_users_Alpha accessKey=U for=users_Alpha>Available " + strHeader + "</LABEL></TH>"))
        objSTBuilder.Append(" <TH>&nbsp;</TH>")
        objSTBuilder.Append(" <TH>&nbsp;</TH>")
        objSTBuilder.Append(" <TH>&nbsp;</TH>")
        objSTBuilder.Append(("<TH style='VERTICAL-ALIGN: bottom'><LABEL id=idLbl_users_Beta accessKey=R for=users_Beta>Selected " + strHeader + "</LABEL></TH>"))
        objSTBuilder.Append("<TH>&nbsp;</TH>")
        objSTBuilder.Append("<TH>&nbsp;</TH></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append("<TD id=idSwpUsers_ShowAlphaUpDownBtn_Container style='VERTICAL-ALIGN: middle'>")
        objSTBuilder.Append("<TABLE class=ms-stdtxt cellSpacing=1 cellPadding=1>")
        objSTBuilder.Append("<TBODY>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append("<TD><BUTTON class=pwa-ButtonHeight id=idSwpUsers_BtnAlphaUp title='Move Up' style='WIDTH: 6em' disabled accessKey=u>Up</BUTTON></TD></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append("<TD><BUTTON class=pwa-ButtonHeight id=idSwpUsers_BtnAlphaDown title='Move Down' style='WIDTH: 6em' disabled accessKey=w>Down</BUTTON></TD></TR></TBODY></TABLE></TD>")
        objSTBuilder.Append("<TD>&nbsp;</TD>")

        objSTBuilder.Append("<TD id=idSwpUsers_AlphaList_Container>")
        objSTBuilder.Append(("<SELECT id=List1" + intPosition + " style='WIDTH: 15em' onchange=Select_OnChange(this); multiple size=7 name=List1" + intPosition + "> "))

        ' create a connection object
        Dim conn As New SqlConnection("server=192.168.100.19;Database=ProjectServer_Whizible;UID=sa;PWD=sa")

        ' declare the SqlDataReader, which is used in
        ' both the try block and the finally block
        Dim rdr As SqlDataReader = Nothing

        ' create a command object
        Dim cmd As New SqlCommand(strsourceSQL, conn)

        Try
            ' open the connection
            conn.Open()

            ' 1.  get an instance of the SqlDataReader
            rdr = cmd.ExecuteReader()

            ' 2.  print necessary columns of each record
            While rdr.Read()
                ' get the results of each column
                Dim Id As String = rdr(0).ToString()
                Dim Name As String = CStr(rdr(1))
                objSTBuilder.Append(("<OPTION value=" + Id + ">" + Name + "</OPTION>"))
            End While
        Finally
            ' 3. close the reader
            If Not (rdr Is Nothing) Then
                rdr.Close()
            End If
        End Try


        objSTBuilder.Append(" </SELECT> ")
        objSTBuilder.Append("</TD>")

        objSTBuilder.Append("<TD>&nbsp;</TD>")

        objSTBuilder.Append("<TD id=idSwpUsers_AddRemove_Container>")
        objSTBuilder.Append("  <TABLE class=ms-stdtxt cellSpacing=1 cellPadding=1>")
        objSTBuilder.Append("               <TBODY>")

        objSTBuilder.Append("               <TR id=idSwpUsers_BtnRemoveItem_Container>")
        objSTBuilder.Append(("               <TD><BUTTON class=pwa-ButtonHeight onclick=removeItem(List1" + intPosition + ",List2" + intPosition + "); id=idSwpUsers_BtnRemoveItem title='' style='WIDTH: 9.5em' enabled accessKey=''>Add &gt;</BUTTON></TD></TR>"))

        objSTBuilder.Append("               <TR id=idSwpUsers_BtnRemoveAll_Container>")
        objSTBuilder.Append(("              <TD><BUTTON class=pwa-ButtonHeight  onclick=removeAll(List1" + intPosition + ",List2" + intPosition + "); id=idSwpUsers_BtnRemoveAll title='' style='WIDTH: 9.5em' enabled accessKey=''>Add All &gt;&gt;</BUTTON></TD></TR>"))

        objSTBuilder.Append("              <TR id=idSwpUsers_BtnRestoreAll_Container>")
        objSTBuilder.Append(("              <TD><BUTTON class=pwa-ButtonHeight  onclick=restoreAll(List1" + intPosition + ",List2" + intPosition + "); id=idSwpUsers_BtnRestoreAll title='' style='WIDTH: 9.5em' enabled accessKey=''>&lt;&lt; Remove All</BUTTON></TD></TR>"))

        objSTBuilder.Append("              <TR id=idSwpUsers_BtnRestoreItem_Container>")
        objSTBuilder.Append(("              <TD><BUTTON class=pwa-ButtonHeight  onclick=restoreItem(List1" + intPosition + ",List2" + intPosition + "); id=idSwpUsers_BtnRestoreItem title='' style='WIDTH: 9.5em' enabled accessKey=''>&lt; Remove</BUTTON></TD></TR>"))

        objSTBuilder.Append("</TBODY></TABLE></TD>")

        objSTBuilder.Append("                <TD>&nbsp;</TD>")

        objSTBuilder.Append("                <TD id=idSwpUsers_BetaList_Container>")
        objSTBuilder.Append(("                    <SELECT id=List2" + intPosition + "  style='WIDTH: 15em' onchange=Select_OnChange(this); size=7 name=List2" + intPosition + "> "))

        ' declare the SqlDataReader, which is used in
        ' both the try block and the finally block
        rdr = Nothing

        ' create a command object
        cmd = New SqlCommand(strDestSQL, conn)

        Try
            ' 1.  get an instance of the SqlDataReader
            rdr = cmd.ExecuteReader()

            ' 2.  print necessary columns of each record
            While rdr.Read()
                ' get the results of each column
                Dim Id As String = rdr(0).ToString()
                Dim Name As String = CStr(rdr(1))
                objSTBuilder.Append(("<OPTION value=" + Id + ">" + Name + "</OPTION>"))
            End While
        Finally
            ' 3. close the reader
            If Not (rdr Is Nothing) Then
                rdr.Close()
            End If

            ' close the connection
            If Not (conn Is Nothing) Then
                conn.Close()
            End If
        End Try



        objSTBuilder.Append("                    </SELECT> ")
        objSTBuilder.Append("                 </TD>")

        objSTBuilder.Append("               <TD>&nbsp;</TD>")

        objSTBuilder.Append("               <TD id=idSwpUsers_ShowBetaUpDown_Container style='VERTICAL-ALIGN: middle'>")

        objSTBuilder.Append("               <TABLE class=ms-stdtxt cellSpacing=1 cellPadding=1>")
        objSTBuilder.Append("                <TBODY>")

        objSTBuilder.Append("                 <TR>")
        objSTBuilder.Append("                 <TD><BUTTON class=pwa-ButtonHeight id=idSwpUsers_BtnBetaUp title='Move Up' style='WIDTH: 6em' disabled accessKey=u>Up</BUTTON></TD></TR>")

        objSTBuilder.Append("                  <TR>")
        objSTBuilder.Append("                  <TD><BUTTON class=pwa-ButtonHeight id=idSwpUsers_BtnBetaDown title='Move Down' style='WIDTH: 6em' disabled accessKey=d>Down</BUTTON></TD></TR>")

        objSTBuilder.Append("</tbody> ")
        objSTBuilder.Append("</Table>")

        objSTBuilder.Append(" </TABLE>")
        objSTBuilder.Append(" </TD></TR></TBODY></TABLE>")


        objSTBuilder.Append(" <TABLE class=ms-stdtxt style='MARGIN-TOP: 3px' cellSpacing=1 cellPadding=1 border=0>")
        objSTBuilder.Append("<TBODY>")
        objSTBuilder.Append("                     <TR>")
        objSTBuilder.Append("                     <TD id=idSwpUsers_LblSelectedItem>&nbsp;</TD></TR></TBODY></TABLE></DIV></TD></TR></TBODY></TABLE></DIV></TD></TR>")
        objSTBuilder.Append("                      <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_tablerow5>")
        objSTBuilder.Append("                      <TD><IMG height=6 alt='' src='1033/blank.gif' width=1></TD></TR></TBODY></TABLE></TD>")
        objSTBuilder.Append("                  <TD width=10><IMG height=1 alt='' src='1033/blank.gif' width=10></TD></TR>")
        objSTBuilder.Append("                <TR>")
        objSTBuilder.Append("                  <TD>")
        objSTBuilder.Append("                 <TD><IMG height=13 alt='' src='1033/blank.gif' width=150></TD>")
        objSTBuilder.Append("                  <TD></TD></TR></TBODY></TABLE></TD></TR>")
        objSTBuilder.Append("  <TR>")
        objSTBuilder.Append("            <TD class=ms-sectionline colSpan=2 height=1></TD></TR>")
        objSTBuilder.Append("</Table>")
    End Sub 'CreateHTMLforSectionListBox


    Private Sub ShowProjectTypeInformation(ByVal strProjectTypeID As String)
        Dim strProjectType As String
        Dim strDescription As String

        ' create a connection object
        Dim conn As New SqlConnection("server=192.168.100.19;Database=ProjectServer_Whizible;UID=sa;PWD=sa")

        ' declare the SqlDataReader, which is used in
        ' both the try block and the finally block
        Dim rdr As SqlDataReader = Nothing

        ' create a command object
        Dim cmd As New SqlCommand("select projecttype,isnull([Description],'') as [Description] from tbl_PRS_ProjectTypes where TypeId=" + strProjectTypeID, conn)

        Try
            ' open the connection
            conn.Open()

            ' 1.  get an instance of the SqlDataReader
            rdr = cmd.ExecuteReader()
            rdr.Read()
            ' get the results of each column
            strProjectType = CStr(rdr(0))
            strDescription = CStr(rdr(1))
        Finally
            ' 3. close the reader
            If Not (rdr Is Nothing) Then
                rdr.Close()
            End If
            ' close the connection
            If Not (conn Is Nothing) Then
                conn.Close()
            End If
        End Try

        'objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=1 width='95%' align='center' border=0>");
        'objSTBuilder.Append("<TR> <TD class=ms-sectionline colSpan=2 height=1></TD></TR>");
        'objSTBuilder.Append("<TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails>");
        'objSTBuilder.Append("<TD class=ms-descriptiontext vAlign=top width='40%'>");
        'objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=1 width='100%' border=0>");
        'objSTBuilder.Append("<TBODY>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append("  <TD class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22><H3 class=ms-standardheader>Project Type Information </H3></TD>");
        'objSTBuilder.Append("</TR>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append(" <TD class='ms-descriptiontext ms-inputformdescription'>Enter a name and description for this Project Type. </TD>");
        'objSTBuilder.Append("</TR>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append(" <TD><IMG height=19 alt='' src='1033/blank.gif' width=150></TD>");
        'objSTBuilder.Append("</TR>");
        'objSTBuilder.Append("</TBODY>");
        'objSTBuilder.Append("</TABLE>");
        'objSTBuilder.Append(" </TD>");
        'objSTBuilder.Append("<TD class='ms-authoringcontrols ms-inputformcontrols' vAlign=top align=left  width='60%'>");
        'objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>");
        'objSTBuilder.Append(" <TBODY>");
        'objSTBuilder.Append("<TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01_tablerow1>");
        'objSTBuilder.Append("<TD class=ms-authoringcontrols noWrap colSpan=2><SPAN id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01_LiteralLabelText></SPAN></TD></TR>");
        'objSTBuilder.Append(" <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01_tablerow2>");
        'objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>");
        'objSTBuilder.Append(" </TR>");
        'objSTBuilder.Append(" <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01_tablerow3>");
        'objSTBuilder.Append(" <TD class=ms-authoringcontrols width='99%'>");
        'objSTBuilder.Append("<DIV id=idDivDetails>");
        'objSTBuilder.Append("<TABLE dataFld=SecurityGroups class=ms-stdtxt style='WIDTH: 100%'>");
        'objSTBuilder.Append("<TBODY>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>");
        'objSTBuilder.Append("<TD colSpan=3><LABEL accessKey=n for=idGroupName>Project Type:</LABEL></TD>");
        'objSTBuilder.Append("    </TR>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>");
        'objSTBuilder.Append("<TD colSpan=3><INPUT value='" + strProjectType + "' id=projecttypename style='WIDTH: 60%'maxLength=255 name=ProjecttypeName></TD>");
        'objSTBuilder.Append("<INPUT type=hidden value='" + strProjectTypeID + "' id=projecttypeID style='WIDTH: 60%'maxLength=255 name=ProjecttypeID>");
        'objSTBuilder.Append("</TR>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>");
        'objSTBuilder.Append("<TD colSpan=3><LABEL accessKey=R for=idGroupDesc>Description:</LABEL></TD></TR>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>");
        'objSTBuilder.Append("<TD colSpan=3><INPUT value='" + strDescription + "' id=idGroupDesc style='WIDTH: 60%' maxLength=1000 name=idGroupDesc></TD>");
        'objSTBuilder.Append("</TR></TBODY></TABLE></DIV>");
        'objSTBuilder.Append("</TD></TR>");
        'objSTBuilder.Append(" </TBODY></TABLE></TD></TR>");
        'objSTBuilder.Append("<TR> <TD class=ms-sectionline colSpan=2 height=1></TD></TR>");
        'objSTBuilder.Append("</TABLE>");


        Dim strHeaderDescription As String = ""
        Dim strHeader As String = ""

        objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=1 width='95%' align='center' border=0>")
        objSTBuilder.Append("<TR><TD class=ms-sectionline colSpan=2 height=1></TD></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22 width='40%'>")
        objSTBuilder.Append((" <H3 class=ms-standardheader><A onclick=javascript:ShowHideSection(this,'" + intPosition + "')><IMG style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' lt=Hide/Show src='1033/minus.gif' border=0>&nbsp; " + strHeader + " </H3></A></TD>"))
        objSTBuilder.Append("</TR>")
        objSTBuilder.Append("<TR>")

        objSTBuilder.Append("<TD class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22><H3 class=ms-standardheader>Project Type Information </H3></TD>")
        objSTBuilder.Append("</TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD class='ms-descriptiontext ms-inputformdescription'>Enter a name and description for this Project Type. </TD>")


        'objSTBuilder.Append("</TR>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append(" <TD><IMG height=19 alt='' src='1033/blank.gif' width=150></TD>");
        'objSTBuilder.Append("</TR>");

        'objSTBuilder.Append("<IMG onclick=javascript:ShowHideSection(this,'ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers') style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' alt='Hide/Show' src='1033/minus.gif' border=0>&nbsp;<H3 class=ms-standardheader>&nbsp; Phases </H3>");
        objSTBuilder.Append(" <TD class=ms-authoringcontrols>&nbsp;</TD></TR>")
        objSTBuilder.Append((" <TR id=" + intPosition + ">"))
        objSTBuilder.Append("    <TD class=ms-descriptiontext vAlign=top>")
        objSTBuilder.Append("    <TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("      <TBODY>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(("  <TD class='ms-descriptiontext ms-inputformdescription'>" + strHeaderDescription + "</TD>"))
        objSTBuilder.Append("<TD><IMG height=1 alt='' src='1033/blank.gif' width=8></TD></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD><IMG height=19 alt='' src='1033/blank.gif' width=150></TD></TR></TBODY></TABLE></TD>")

        objSTBuilder.Append("<TD class='ms-authoringcontrols ms-inputformcontrols' vAlign=top align=left>")
        objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append("  <TD>")
        objSTBuilder.Append("  <TD class=ms-authoringcontrols>")
        objSTBuilder.Append("   <TABLE class=ms-authoringcontrols cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append("     <TBODY>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_tablerow1>")
        objSTBuilder.Append("     <TD class=ms-authoringcontrols noWrap colSpan=2>")
        objSTBuilder.Append("         <SPAN id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_LiteralLabelText></SPAN></TD></TR>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_tablerow2>")
        objSTBuilder.Append("     <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD></TR>")
        objSTBuilder.Append("     <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_tablerow3>")
        objSTBuilder.Append("<TD width=11><IMG height=1 alt='' src='1033/blank.gif' width=11></TD>")
        objSTBuilder.Append(" <TD class=ms-authoringcontrols width='99%'>")
        objSTBuilder.Append(" <DIV id=idDivUsers>")
        objSTBuilder.Append(" <TABLE>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append(" <TR>")
        objSTBuilder.Append(" <TD>")
        objSTBuilder.Append(" <DIV id=idSwpUsers style='VISIBILITY: visible; BEHAVIOR: url(/_layouts/PWA/Library/ItemSwapper.htc)'>")
        objSTBuilder.Append(" <TABLE class=ms-stdtxt cellSpacing=1 cellPadding=1 border=0>")
        objSTBuilder.Append(" <COLGROUP>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColAlphaUpDown style='DISPLAY: none' span=2>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColAlphaList>")
        objSTBuilder.Append(" <COL>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColRemoveRestore>")
        objSTBuilder.Append(" <COL>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColBetaList>")
        objSTBuilder.Append(" <COL id=idSwpUsers_ColBetaUpDown style='DISPLAY: none' span=2></COLGROUP>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append(" <TR>")
        'objSTBuilder.Append(" <TH>&nbsp;</TH>");
        'objSTBuilder.Append("<TH>&nbsp;</TH>");



        objSTBuilder.Append("<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>")
        objSTBuilder.Append(" <TBODY>")
        objSTBuilder.Append("<TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01_tablerow1>")
        objSTBuilder.Append("<TD class=ms-authoringcontrols noWrap colSpan=2><SPAN id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01_LiteralLabelText></SPAN></TD></TR>")
        objSTBuilder.Append(" <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01_tablerow2>")
        objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>")
        objSTBuilder.Append(" </TR>")
        objSTBuilder.Append(" <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionDetails_ctl01_tablerow3>")
        objSTBuilder.Append(" <TD class=ms-authoringcontrols width='99%'>")
        objSTBuilder.Append("<DIV id=idDivDetails>")
        objSTBuilder.Append("<TABLE dataFld=SecurityGroups class=ms-stdtxt style='WIDTH: 100%'>")
        objSTBuilder.Append("<TBODY>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>")
        objSTBuilder.Append("<TD colSpan=3><LABEL accessKey=n for=idGroupName>Project Type:</LABEL></TD>")
        objSTBuilder.Append("    </TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>")
        objSTBuilder.Append(("<TD colSpan=3><INPUT value='" + strProjectType + "' id=projecttypename style='WIDTH: 400px'maxLength=255 name=ProjecttypeName></TD>"))
        objSTBuilder.Append(("<INPUT type=hidden value='" + strProjectTypeID + "' id=projecttypeID style='WIDTH: 60%'maxLength=255 name=ProjecttypeID>"))
        objSTBuilder.Append("</TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>")
        objSTBuilder.Append("<TD colSpan=3><LABEL accessKey=R for=idGroupDesc>Description:</LABEL></TD></TR>")
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append(" <TD><IMG height=3 alt='' src='1033/blank.gif' width=1></TD>")
        objSTBuilder.Append(("<TD colSpan=3><INPUT value='" + strDescription + "' id=idGroupDesc style='WIDTH: 400px' maxLength=1000 name=idGroupDesc></TD>"))
        objSTBuilder.Append("</TR></TBODY></TABLE></DIV>")
        objSTBuilder.Append("</TD></TR>")

        objSTBuilder.Append(" </TBODY></TABLE></TD></TR>")


        'objSTBuilder.Append(" <TH style='VERTICAL-ALIGN: bottom'><LABEL id=idLbl_users_Alpha accessKey=U for=users_Alpha>Available " + strHeader + "</LABEL></TH>");
        'objSTBuilder.Append(" <TH>&nbsp;</TH>");
        'objSTBuilder.Append(" <TH>&nbsp;</TH>");
        'objSTBuilder.Append(" <TH>&nbsp;</TH>");
        'objSTBuilder.Append("<TH style='VERTICAL-ALIGN: bottom'><LABEL id=idLbl_users_Beta accessKey=R for=users_Beta>Selected " + strHeader + "</LABEL></TH>");
        'objSTBuilder.Append("<TH>&nbsp;</TH>");
        'objSTBuilder.Append("<TH>&nbsp;</TH></TR>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append("<TD id=idSwpUsers_ShowAlphaUpDownBtn_Container style='VERTICAL-ALIGN: middle'>");
        'objSTBuilder.Append("<TABLE class=ms-stdtxt cellSpacing=1 cellPadding=1>");
        'objSTBuilder.Append("<TBODY>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append("<TD><BUTTON class=pwa-ButtonHeight id=idSwpUsers_BtnAlphaUp title='Move Up' style='WIDTH: 6em' disabled accessKey=u>Up</BUTTON></TD></TR>");
        'objSTBuilder.Append("<TR>");
        'objSTBuilder.Append("<TD><BUTTON class=pwa-ButtonHeight id=idSwpUsers_BtnAlphaDown title='Move Down' style='WIDTH: 6em' disabled accessKey=w>Down</BUTTON></TD></TR></TBODY></TABLE></TD>");
        'objSTBuilder.Append("<TD>&nbsp;</TD>");


        'objSTBuilder.Append("                 <TR>");
        'objSTBuilder.Append("                 <TD><BUTTON class=pwa-ButtonHeight id=idSwpUsers_BtnBetaUp title='Move Up' style='WIDTH: 6em' disabled accessKey=u>Up</BUTTON></TD></TR>");
        'objSTBuilder.Append("                  <TR>");
        'objSTBuilder.Append("                  <TD><BUTTON class=pwa-ButtonHeight id=idSwpUsers_BtnBetaDown title='Move Down' style='WIDTH: 6em' disabled accessKey=d>Down</BUTTON></TD></TR>");
        'objSTBuilder.Append("	</TBODY>");
        'objSTBuilder.Append("	</TABLE>");
        'objSTBuilder.Append("	</TD></TR></TBODY></TABLE>");


        objSTBuilder.Append("<TABLE class=ms-stdtxt style='MARGIN-TOP: 3px' cellSpacing=1 cellPadding=1 border=0>")
        objSTBuilder.Append("<TBODY>")

        objSTBuilder.Append("                     <TR>")
        objSTBuilder.Append("                     <TD id=idSwpUsers_LblSelectedItem>&nbsp;</TD></TR></TBODY></TABLE></DIV></TD></TR></TBODY></TABLE></DIV></TD></TR>")
        objSTBuilder.Append("                      <TR id=ctl00_ctl00_PlaceHolderMain_PWA_PlaceHolderMain_idFormSectionUsers_ctl01_tablerow5>")
        objSTBuilder.Append("                      <TD><IMG height=6 alt='' src='1033/blank.gif' width=1></TD></TR></TBODY></TABLE></TD>")
        objSTBuilder.Append("                  <TD width=10><IMG height=1 alt='' src='1033/blank.gif' width=10></TD></TR>")
        objSTBuilder.Append("                <TR>")
        objSTBuilder.Append("                  <TD>")
        objSTBuilder.Append("                 <TD><IMG height=13 alt='' src='1033/blank.gif' width=150></TD>")
        objSTBuilder.Append("                  <TD></TD></TR></TBODY></TABLE></TD></TR>")
        objSTBuilder.Append("  <TR>")
        objSTBuilder.Append("            <TD class=ms-sectionline colSpan=2 height=1></TD></TR>")
        objSTBuilder.Append("</Table>")
    End Sub 'ShowProjectTypeInformation 

#End Region

#Region "Supporting Functions"

    Private Sub DrawGroupLine()
        objSTBuilder.Append("<tr width='100%'>")
        objSTBuilder.Append("<TD class='ms-sectionline' colSpan='2' height='1'>")
        objSTBuilder.Append("<IMG height='1' alt='' src='blank.gif' width='1'>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
    End Sub 'DrawGroupLine


#End Region
End Class 'ProjectType 