Imports System.Text
Imports System.Data.SqlClient
Imports System.Data
Partial Public Class WhizProjectType
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Private Const"

    Private Enum GridType
        CONFIGURE_PROCESSES = 1
        CONFIGURE_METRICES = 2
    End Enum

    Private Const PROJECT_TYPE_PHASE As String = "Phases"
    Private Const PROJECT_TYPE_TASKTYPE As String = "Task Types"
    Private Const PROJECT_TYPE_ISSUETYPE As String = "Issue Types"
    Private Const PROJECT_TYPE_REVIEWTYPES As String = "Review Types"
    Private Const PROJECT_TYPE_CORPORATERISKS As String = "Corporate Risks"
    Private Const PROJECT_TYPE_PROCESSES As String = "Configure Processes"
    Private Const PROJECT_TYPE_METRICS = "Configure Metrics"


    Private Const PROJECT_TYPE_PHASE_DES As String = "Select the phases that belong to this Project Type"
    Private Const PROJECT_TYPE_TASKTYPE_DES As String = "Select the Task types you want to configure for this Project Type."
    Private Const PROJECT_TYPE_ISSUETYPE_DES As String = "Select Issue types which are applicable for selected Project type."
    Private Const PROJECT_TYPE_REVIEWTYPES_DES As String = "Select Review types which are applicable for selected Project type."
    Private Const PROJECT_TYPE_CORPORATERISKS_DES As String = "Select Corporate Risks which are applicable for selected Project type."
    Private Const PROJECT_TYPE_PROCESSES_DES As String = "Select the Processes and there activities for this project Type "
    Private Const PROJECT_TYPE_METRICS_DES As String = "Select the Metrics which are applicable for this project Type "

    Private m_strConnectionString As String = ""
    Private m_intProjectTypeID As Integer = 0
    Private strProjectTypeGUID As String = ""
    Protected m_intPMIID As Integer
    Private ACTION_ADD = "ADD"
    Private ACTION_SAVE = "SAVE"

    Protected m_strCurrentAction = ""

    Private Const PROJECT_PROCESS_SELECTION_HEADING = "Process"
    Private Const PROJECT_PROCESS_ACTIVITY_HEADING = "Activity"

    Private Const PROJECT_CATEGORY_SELECTION_HEADING = "Metric Category"
    Private Const PROJECT_CATEGORY_METRIC_HEADING = "Metric"
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        'add client side script to button
        btnTopSave.Attributes.Add("OnClick", "SetSelectedValues();ValidateGCT()")
        btnBottomModify.Attributes.Add("OnClick", "SetSelectedValues();ValidateGCT()")

        btnComputePMI.Attributes.Add("OnClick", "ComputePMI()")
        btnBottomComputePMI.Attributes.Add("OnClick", "ComputePMI()")

        GetGlobalSettings()
        'set button & label values values
        SetFunctionalityButtonsAndLabel()

        If (Page.IsPostBack = False) Then
            PopulateData()
        End If
    End Sub
#Region "private utility functions"
    Private Function SetTemplateCreationStatus() As String
        'According to the queue status and already created template
        'label text is set
        Dim strReturnValue As String
        Dim strSQL As String
        strSQL = "USP_Sel_TemplateStatus " + m_intProjectTypeID.ToString()
        strReturnValue = System.Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, True, m_strConnectionString))
        Return strReturnValue
    End Function


    Private Sub SetFunctionalityButtonsAndLabel()
        If m_intProjectTypeID = 0 Then
            btnCreatePublishTemplate.Visible = False
            btnBottomCreatePublishTemplate.Visible = False

            btnComputePMI.Visible = False
            btnBottomComputePMI.Visible = False
        Else
            Dim strPublishButtonCaption As String = GetPublishButtonCaption()
            btnCreatePublishTemplate.Visible = True
            btnBottomCreatePublishTemplate.Visible = True

            btnCreatePublishTemplate.Text = strPublishButtonCaption
            btnBottomCreatePublishTemplate.Text = strPublishButtonCaption

            btnComputePMI.Visible = True
            btnBottomComputePMI.Visible = True
        End If
        lblTemplateStatus.Text = SetTemplateCreationStatus()
    End Sub

    Private Function GetPublishButtonCaption() As String
        '************************************************************
        'Function Name  : GetPublishButtonCaption
        'Created By     : NiranjanK
        'Created Date   : Jan 24,2007
        'Purpose        : To get the caption for create / publish button
        '************************************************************
        Dim strSQL As String = "SELECT P12GUID FROM tbl_PRS_ProjectTypes WHERE TypeID = " + m_intProjectTypeID.ToString()
        Dim strReturnValue As String
        strReturnValue = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True, m_strConnectionString), "")
        If (strReturnValue = "") Then
            strReturnValue = "Create Template"
            strProjectTypeGUID = ""
        Else
            strProjectTypeGUID = strReturnValue
            strReturnValue = "Publish Template"
        End If
        Return strReturnValue
    End Function

    Private Sub GetGlobalSettings()
        m_strCurrentAction = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), ACTION_ADD)
        m_strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString")
        m_strConnectionString = CommonFunctions.General.BuildConnectionString(m_strConnectionString)
        If (m_intProjectTypeID = 0) Then m_intProjectTypeID = System.Convert.ToInt32(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectTypeID"), "0"))
        If (m_intProjectTypeID > 0) Then m_intPMIID = GetPMIID()
    End Sub

    Private Function GetPMIID() As Integer
        Dim strSQL As String = "SELECT PMIID FROM tbl_PRS_ProjectType_PMI WHERE ProjectTypeID = " + m_intProjectTypeID.ToString()
        Dim intPMIID As Integer
        intPMIID = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True, m_strConnectionString), "0"))
        Return intPMIID
    End Function

    Private Sub PopulateData()
        Dim strSQL As String
        Dim objDataReader As IDataReader
        strSQL = "SELECT ProjectType,[Description] FROM tbl_PRS_ProjectTypes WHERE TypeID = " + m_intProjectTypeID.ToString
        objDataReader = CommonFunctions.Data.GetDataReader(strSQL, True, m_strConnectionString, False, False)
        If (objDataReader.Read()) Then
            txtProjectType.Text = CommonFunctions.Data.CheckIsDBNull(objDataReader(0), "")
            txtProjectTypeDescription.Text = CommonFunctions.Data.CheckIsDBNull(objDataReader(1), "")
        End If
        CommonFunction.Data.DisposeDataReader(objDataReader)
        If (Not objDataReader Is Nothing) Then objDataReader = Nothing
        'Populate Plans
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT PlanID,Title FROM tbl_PRS_CorporatePlans WHERE PlanID NOT IN (SELECT PlanID FROM tbl_PRS_ProjectPlans WHERE ProjectTypeId =" + m_intProjectTypeID.ToString() + ") ORDER BY Title"
        strSQL = "usp_sel_tbl_PRS_CorporatePlans_PlanIDNot " + m_intProjectTypeID.ToString()
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstAvailablePlans, strSQL)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT CP.PlanID,CP.Title FROM tbl_PRS_CorporatePlans CP INNER JOIN tbl_PRS_ProjectPlans PP ON CP.PlanID = PP.PlanID WHERE ProjectTypeID = " + m_intProjectTypeID.ToString() + "  ORDER BY Title"
        strSQL = "usp_sel_tbl_PRS_CorporatePlans_PlanID " + m_intProjectTypeID.ToString()
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstSelectedPlans, strSQL)
        'Populate phases
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT PhaseId,Phase FROM tbl_IB_Phases WHERE PhaseID NOT IN (SELECT PhaseId FROM tbl_PRS_ProjectType_Phases WHERE ProjectTypeId =" + m_intProjectTypeID.ToString() + ") ORDER BY Phase"
        strSQL = "usp_sel_tbl_IB_Phases_PhaseIdNot " + m_intProjectTypeID.ToString()
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstAvailablePhases, strSQL)
        'strSQL = "SELECT PhaseId,Phase FROM tbl_IB_Phases WHERE PhaseID IN (SELECT PhaseId FROM tbl_PRS_ProjectType_Phases WHERE ProjectTypeId =" + m_intProjectTypeID.ToString() + ") ORDER BY Phase"
        strSQL = "usp_sel_tbl_IB_Phases_PhaseId " + m_intProjectTypeID.ToString()
        PopulateList(lstSelectedPhases, strSQL)
        'Populate task types
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT TasktypeId,Tasktype FROM tbl_PM_TaskTypes where TasktypeId NOT IN (SELECT TaskTypeId from tbl_PM_ProjectTypes_TaskTypes WHERE ProjectTypeId = " + m_intProjectTypeID.ToString(0) + ") ORDER BY TaskType"
        strSQL = "usp_sel_tbl_PM_TaskTypes_TasktypeIdNot " + m_intProjectTypeID.ToString(0)
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstAvailableTaskTypes, strSQL)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT TasktypeId,Tasktype FROM tbl_PM_TaskTypes where TasktypeId IN (SELECT TaskTypeId from tbl_PM_ProjectTypes_TaskTypes WHERE ProjectTypeId = " + m_intProjectTypeID.ToString(0) + ") ORDER BY TaskType"
        strSQL = "usp_sel_tbl_PM_TaskTypes_TasktypeId " + m_intProjectTypeID.ToString(0)
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstSelectedTaskTypes, strSQL)
        'Populate issue types
        'strSQL = "SELECT TypeID,Type FROM tbl_IB_Type WHERE TypeID NOT IN (SELECT TypeID FROM tbl_PM_ProjectTypes_IssueTypes WHERE ProjectTypeID= " + m_intProjectTypeID.ToString() + ") ORDER BY Type"
        strSQL = "usp_sel_tbl_PM_ProjectTypesIssue_Types_For_TaskTypeConfiguration_P12 " + m_intProjectTypeID.ToString()
        PopulateList(lstAvailableIssueTypes, strSQL)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT TypeID,Type FROM tbl_IB_Type WHERE TypeID IN (SELECT TypeID FROM tbl_PM_ProjectTypes_IssueTypes WHERE ProjectTypeID= " + m_intProjectTypeID.ToString() + ") ORDER BY Type"
        strSQL = "usp_sel_tbl_IB_Type_TypeID " + m_intProjectTypeID.ToString()
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstSelectedIssueTypes, strSQL)
        'populate review types
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT Distinct CReviewTypeID,CReviewType FROM tbl_PM_CorporateReviewTypes INNER JOIN tbl_PM_ProjectTypes_TaskTypes ON tbl_PM_CorporateReviewTypes.TaskTypeID = tbl_PM_ProjectTypes_TaskTypes.TaskTypeID AND tbl_PM_ProjectTypes_TaskTypes.ProjectTypeID = " + m_intProjectTypeID.ToString() + " AND tbl_PM_CorporateReviewTypes.CReviewTypeID NOT IN(Select CReviewTypeID FROM tbl_PM_ProjectTypes_ReviewTypes WHERE ProjectTypeID=" + m_intProjectTypeID.ToString() + ")"
        strSQL = "usp_sel_tbl_PM_CorporateReviewTypes_CReviewTypeIDJoin " + m_intProjectTypeID.ToString()
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstAvailableReviewTypes, strSQL)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = " SELECT CReviewTypeID,CReviewType FROM tbl_PM_CorporateReviewTypes   WHERE CReviewTypeID in (Select CReviewTypeID FROM tbl_PM_ProjectTypes_ReviewTypes WHERE ProjectTypeID=" + m_intProjectTypeID.ToString() + ")"
        strSQL = "usp_sel_tbl_PM_CorporateReviewTypes_CReviewTypeID " + m_intProjectTypeID.ToString()
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

        PopulateList(lstSelectedReviewTypes, strSQL)
        'Populate risks
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT tbl_PM_CorporateRisks.CorporateRiskID,tbl_PM_CorporateRisks.[Description] FROM tbl_PM_CorporateRisks  WHERE tbl_PM_CorporateRisks.CorporateRiskID NOT IN(Select CorporateRiskID FROM tbl_PM_ProjectType_CorporateRisk   WHERE ProjectTypeID=" + m_intProjectTypeID.ToString() + ")"
        strSQL = "usp_sel_tbl_PM_CorporateRisks_CorporateRiskIDNot " + m_intProjectTypeID.ToString()
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstAvailableCorporateRisks, strSQL)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT tbl_PM_CorporateRisks.CorporateRiskID,tbl_PM_CorporateRisks.[Description] FROM tbl_PM_CorporateRisks   WHERE  tbl_PM_CorporateRisks.CorporateRiskID IN(Select CorporateRiskID FROM tbl_PM_ProjectType_CorporateRisk   WHERE ProjectTypeID=" + m_intProjectTypeID.ToString() + ")"
        strSQL = "usp_sel_tbl_PM_CorporateRisks_CorporateRiskID " + m_intProjectTypeID.ToString()
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        PopulateList(lstSelectedCorporateRisks, strSQL)
    End Sub

    Private Sub PopulateList(ByVal lstListControl As ListBox, ByVal strSQL As String)
        Dim objDS As New DataSet()
        objDS = CommonFunctions.Data.GetDataSet(strSQL, lstListControl.ID, 0, 0, True, m_strConnectionString)
        lstListControl.DataSource = objDS
        lstListControl.DataMember = objDS.Tables(0).TableName
        lstListControl.DataValueField = objDS.Tables(0).Columns(0).ColumnName
        lstListControl.DataTextField = objDS.Tables(0).Columns(1).ColumnName
        lstListControl.DataBind()
    End Sub

    Private Function GetSelectedValues(ByVal lstSelectionListBox As ListBox) As String
        Dim strSelectedIDs As String = ""
        For Each lstSelectedItem As ListItem In lstSelectionListBox.Items
            If (lstSelectedItem.Selected = True) Then
                strSelectedIDs = strSelectedIDs + lstSelectedItem.Value + ","
            End If
        Next
        If (strSelectedIDs.Length > 0) Then
            strSelectedIDs = strSelectedIDs.Substring(0, strSelectedIDs.Length - 1)
        End If
        Return (strSelectedIDs)
    End Function

    Protected Sub Synchronize_Lists(ByVal lstListBoxSource As ListBox, ByVal lstListBoxDestination As ListBox)
        ''=====================================================================
        '        ' Procedure Name        : Synchronize_Guidelines
        '        ' Purpose               : To synchronize Guidelines in available and selected Guidelines
        '                                  from client side to server control.
        '        ' Description           : 
        '        ' Parameters Passed     : 
        '        ' Returns               : NA
        '        ' Parameters Affected   : 
        '        ' Assumptions           : 
        '        ' Dependencies          : 
        '        ' Author                : NitinVS
        '        ' Created               : Nov 21,2006
        '        ' Revisions             :
        '        '=====================================================================
        Dim objLSTITM As ListItem
        For Each objLSTITM In lstListBoxSource.Items
            If objLSTITM.Selected = False Then
                objLSTITM.Selected = True
                lstListBoxDestination.Items.Add(objLSTITM)
            End If
        Next objLSTITM

        'remove the ietms added to selected list from available list 
        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstListBoxDestination.Items
            If lstListBoxSource.Items.IndexOf(objLSTITM) > -1 Then
                lstListBoxSource.Items.Remove(objLSTITM)
            End If
        Next objLSTITM


        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstListBoxDestination.Items
            If objLSTITM.Selected = False Then
                objLSTITM.Selected = True
                lstListBoxSource.Items.Add(objLSTITM)
            End If
        Next objLSTITM

        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstListBoxSource.Items
            If lstListBoxDestination.Items.IndexOf(objLSTITM) > -1 Then
                lstListBoxDestination.Items.Remove(objLSTITM)
            End If
        Next objLSTITM

        lstListBoxDestination.ClearSelection()
        lstListBoxSource.ClearSelection()
    End Sub 'Synchronize_Guidelines
#End Region

    Public Sub DrawMetricesTable()
        'display all the processes associated with the selected project type
        Dim strSourceSQL As String
        strSourceSQL = "EXEC USP_SEL_Get_ProjectType_Metrics " + m_intProjectTypeID.ToString()
        CreateHTMLForMultiSelection(PROJECT_CATEGORY_SELECTION_HEADING, PROJECT_CATEGORY_METRIC_HEADING, strSourceSQL, GridType.CONFIGURE_METRICES)
    End Sub

    Public Sub DrawProcessesTable()
        'display all the processes associated with the selected project type
        Dim strSourceSQL As String
        strSourceSQL = "EXEC usp_sel_GetListOfProcess " + m_intProjectTypeID.ToString()
        CreateHTMLForMultiSelection(PROJECT_PROCESS_SELECTION_HEADING, PROJECT_PROCESS_ACTIVITY_HEADING, strSourceSQL, GridType.CONFIGURE_PROCESSES)
    End Sub

    Private Sub CreateHTMLForMultiSelection(ByVal strHeader As String, _
        ByVal strHeaderDescription As String, _
        ByVal strsourceSQL As String, _
        ByVal intGridType As GridType)

        Dim objSTBuilder As New StringBuilder()
        Dim strAvailableMasters As String = ""
        Dim strTableID As String = ""
        objSTBuilder.Append("<DIV style='BACKGROUND-COLOR: window;WIDTH:60%'>")
        If (intGridType = GridType.CONFIGURE_PROCESSES) Then
            strTableID = "tblConfigureProcesses"
        Else
            strTableID = "tblConfigureMetrics"
        End If
        objSTBuilder.Append("<TABLE SelectionType ='RowOnly' class=XmlGridTable id='")
        objSTBuilder.Append(strTableID)
        objSTBuilder.Append("'>")
        objSTBuilder.Append("<TBODY>")

        'This is the heading of the grid
        objSTBuilder.Append("<TR class=XmlGridTitleRow style='HEIGHT: 22px'>")

        objSTBuilder.Append("<TD style='WIDTH: 30px' noWrap ColID='ENABLED' Type='Image'>")
        objSTBuilder.Append("<A class=XmlGridSortLink><NOBR></NOBR></A>")
        objSTBuilder.Append("</TD>")

        objSTBuilder.Append("<TD style='WIDTH: 100%' noWrap ColID='WSEC_FEA_ACT_NAME' Type='Text'>")
        objSTBuilder.Append("<A class=XmlGridSortLink><NOBR>")
        objSTBuilder.Append(strHeader)
        'objSTBuilder.Append("<IMG src='../../Images/P12/QC/UpArrow.gif'>")
        objSTBuilder.Append("</NOBR></A>")
        objSTBuilder.Append("</TD>")

        If (intGridType = GridType.CONFIGURE_METRICES) Then
            objSTBuilder.Append("<TD style='WIDTH: 55px; COOR: navy' noWrap ColID='ALLOW' Type='Checkbox'>")
            objSTBuilder.Append("<A class=XmlGridSortLink><NOBR>")
            objSTBuilder.Append("LCL")
            objSTBuilder.Append("</NOBR></A>")
            objSTBuilder.Append("</TD>")

            objSTBuilder.Append("<TD style='WIDTH: 55px; COOR: navy' noWrap ColID='ALLOW' Type='Checkbox'>")
            objSTBuilder.Append("<A class=XmlGridSortLink><NOBR>")
            objSTBuilder.Append("UCL")
            objSTBuilder.Append("</NOBR></A>")
            objSTBuilder.Append("</TD>")
        End If

        objSTBuilder.Append("<TD style='WIDTH: 55px; COOR: navy' noWrap ColID='ALLOW' Type='Checkbox'>")
        objSTBuilder.Append("<A class=XmlGridSortLink><NOBR>")
        objSTBuilder.Append(strHeaderDescription)
        objSTBuilder.Append("</NOBR></A>")
        objSTBuilder.Append("</TD>")


        objSTBuilder.Append(" </TR>")

        Dim objDataRow As IDataReader
        Dim intMasterID As Integer = 0
        'Get the data
        objDataRow = CommonFunctions.Data.GetDataReader(strsourceSQL, True, m_strConnectionString, False, False)
        intMasterID = 0
        While (objDataRow.Read())
            'get the reults of each column
            Dim strSelect As String
            strSelect = "Checked"

            Dim intTempMasterID As Integer = System.Convert.ToInt32(objDataRow(0))
            Dim strMasterName As String = System.Convert.ToString(objDataRow(1))
            Dim intDetailID As Integer = System.Convert.ToInt32(objDataRow(2))
            Dim strDetailName As String = System.Convert.ToString(objDataRow(3))
            Dim intValue As String = System.Convert.ToInt32(objDataRow(4))
            Dim strMasterCode As String
            Dim strMasterRowName As String
            Dim STYLE_DISPLAY_NONE As String = "style=display:none;width:60px;text-align:right"
            Dim STYLE_DISPLAY_INLINE As String = "style=display:inline;width:60px;text-align:right"
            Dim strCurrentStyle As String = ""

            If intValue = 0 Then
                strSelect = ""
            End If

            If (intGridType = GridType.CONFIGURE_PROCESSES) Then
                strMasterCode = "P"
                strMasterRowName = "PR"
            Else
                strMasterCode = "M"
                strMasterRowName = "MR"
            End If

            If (intMasterID <> intTempMasterID) Then
                intMasterID = intTempMasterID
                'set processid
                strAvailableMasters = strAvailableMasters + intTempMasterID.ToString() + ","

                'New process starting so plot header
                objSTBuilder.Append("<TR id='GridDataRow' style='BACKGROUND-COLOR: #f9f9f9' State='1' Group='0' RowID='afaa8cb3-dd91-490b-a918-70e29e0509a5'>")

                objSTBuilder.Append("<td><a tabindex='0' hidefocus='true' style='height:100%;'></a></td>")
                objSTBuilder.Append("<TD GroupDisplay='1'>")
                objSTBuilder.Append("<A tabindex='0' hideFocus='true' style='HEIGHT: 100%' tabIndex=0>")
                objSTBuilder.Append("<IMG class=XmlGridGroupIcon src='../../Images/P12/QC/whiteminus.gif' onclick=HideDetailRow('")
                objSTBuilder.Append(strTableID)
                objSTBuilder.Append("','")
                objSTBuilder.Append(strMasterRowName + intMasterID.ToString())
                objSTBuilder.Append("',this)>")
                objSTBuilder.Append(strMasterName)
                objSTBuilder.Append("</A>")
                objSTBuilder.Append("</TD>")

                If (intGridType = GridType.CONFIGURE_METRICES) Then
                    objSTBuilder.Append("<TD>")
                    objSTBuilder.Append("&nbsp;")
                    objSTBuilder.Append("</TD>")

                    objSTBuilder.Append("<TD>")
                    objSTBuilder.Append("&nbsp;")
                    objSTBuilder.Append("</TD>")
                End If

                objSTBuilder.Append("<TD>")
                objSTBuilder.Append("<INPUT hideFocus title='Select or clear all items in this group.' type=checkbox ")
                objSTBuilder.Append(strSelect)
                objSTBuilder.Append(" Group='0' onclick='CheckParent(this)' name='")
                objSTBuilder.Append(strMasterCode + intMasterID.ToString())
                objSTBuilder.Append("'></INPUT>")
                objSTBuilder.Append("</TD>")

                objSTBuilder.Append(" </TR>")

                'The header is plot now plot first details
                objSTBuilder.Append("<TR RowID='ab7015f0-e63d-4b9b-838d-c5284a9f99c9' id='")
                objSTBuilder.Append(strMasterRowName + intMasterID.ToString() + "C")
                objSTBuilder.Append("'>")

                objSTBuilder.Append("<td><a tabindex='0' hidefocus='true' style='height:100%;'></a></td>")
                objSTBuilder.Append("<TD>")
                objSTBuilder.Append("<A tabindex='0' hideFocus='true' style='PADDING-LEFT: 30px' tabIndex=0>")
                objSTBuilder.Append(strDetailName)
                objSTBuilder.Append("</A>")
                objSTBuilder.Append("</TD>")

                If (intGridType = GridType.CONFIGURE_METRICES) Then
                    If strSelect = "Checked" Then
                        strCurrentStyle = STYLE_DISPLAY_INLINE
                    Else
                        strCurrentStyle = STYLE_DISPLAY_NONE
                    End If
                    objSTBuilder.Append("<TD>")
                    objSTBuilder.Append("<INPUT width='10' type=TextBox value= ")
                    objSTBuilder.Append(System.Convert.ToString(objDataRow("LCL")))
                    objSTBuilder.Append(" Group='0' onblur='return ValidateLCLUCL(this,event)' name='")
                    objSTBuilder.Append(strMasterCode + intMasterID.ToString() + "LCL")
                    objSTBuilder.Append("' ")
                    objSTBuilder.Append("id='")
                    objSTBuilder.Append(strMasterCode + intMasterID.ToString() + intDetailID.ToString() + "LCL")
                    objSTBuilder.Append("' ")
                    objSTBuilder.Append(strCurrentStyle + ">")
                    objSTBuilder.Append("</INPUT>")
                    objSTBuilder.Append("</TD>")

                    objSTBuilder.Append("<TD>")
                    objSTBuilder.Append("<INPUT width='10' type=TextBox value= ")
                    objSTBuilder.Append(System.Convert.ToString(objDataRow("UCL")))
                    objSTBuilder.Append(" Group='0' onblur='return ValidateLCLUCL(this,event)' name='")
                    objSTBuilder.Append(strMasterCode + intMasterID.ToString() + "UCL")
                    objSTBuilder.Append("' ")
                    objSTBuilder.Append("id='")
                    objSTBuilder.Append(strMasterCode + intMasterID.ToString() + intDetailID.ToString() + "UCL")
                    objSTBuilder.Append("' ")
                    objSTBuilder.Append(strCurrentStyle + ">")
                    objSTBuilder.Append("</INPUT>")
                    objSTBuilder.Append("</TD>")
                End If

                objSTBuilder.Append("<TD style='PADDING-LEFT: 30px'>")
                objSTBuilder.Append("<INPUT hideFocus ")
                objSTBuilder.Append(strSelect)
                objSTBuilder.Append(" type=checkbox name='")
                objSTBuilder.Append(strMasterCode + intMasterID.ToString() + "C")
                objSTBuilder.Append("' value='")
                If (intGridType = GridType.CONFIGURE_PROCESSES) Then
                    objSTBuilder.Append(intMasterID.ToString() + "-" + intDetailID.ToString())
                Else
                    objSTBuilder.Append(intDetailID.ToString())
                End If
                objSTBuilder.Append("'")
                If (intGridType = GridType.CONFIGURE_METRICES) Then
                    objSTBuilder.Append(" onclick='CheckChild(this)' ")
                End If
                objSTBuilder.Append(">")
                objSTBuilder.Append("</INPUT>")
                objSTBuilder.Append("</TD>")
                objSTBuilder.Append("</TR>")
            Else
                objSTBuilder.Append("<TR RowID='ab7015f0-e63d-4b9b-838d-c5284a9f99c9' id='")
                objSTBuilder.Append(strMasterRowName + intMasterID.ToString() + "C")
                objSTBuilder.Append("'>")

                objSTBuilder.Append(" <td><a tabindex='0' hidefocus='true' style='height:100%;'></a></td>")
                objSTBuilder.Append(" <TD>")
                objSTBuilder.Append("<A hideFocus='true' style='PADDING-LEFT: 30px' tabIndex=0>")
                objSTBuilder.Append(strDetailName)
                objSTBuilder.Append("</A>")
                objSTBuilder.Append("</TD>")

                If (intGridType = GridType.CONFIGURE_METRICES) Then
                    If strSelect = "Checked" Then
                        strCurrentStyle = STYLE_DISPLAY_INLINE
                    Else
                        strCurrentStyle = STYLE_DISPLAY_NONE
                    End If
                    objSTBuilder.Append("<TD>")
                    objSTBuilder.Append("<INPUT width='10' type=TextBox value= ")
                    objSTBuilder.Append(System.Convert.ToString(objDataRow("LCL")))
                    objSTBuilder.Append(" Group='0' onblur='return ValidateLCLUCL(this,event)' name='")
                    objSTBuilder.Append(strMasterCode + intMasterID.ToString() + "LCL")
                    objSTBuilder.Append("' ")
                    objSTBuilder.Append("id='")
                    objSTBuilder.Append(strMasterCode + intMasterID.ToString() + intDetailID.ToString() + "LCL")
                    objSTBuilder.Append("' ")
                    objSTBuilder.Append(strCurrentStyle + ">")
                    objSTBuilder.Append("</INPUT>")
                    objSTBuilder.Append("</TD>")

                    objSTBuilder.Append("<TD>")
                    objSTBuilder.Append("<INPUT width='10' type=TextBox value= ")
                    objSTBuilder.Append(System.Convert.ToString(objDataRow("UCL")))
                    objSTBuilder.Append(" Group='0' onblur='return ValidateLCLUCL(this,event)' name='")
                    objSTBuilder.Append(strMasterCode + intMasterID.ToString() + "UCL")
                    objSTBuilder.Append("' ")
                    objSTBuilder.Append("id='")
                    objSTBuilder.Append(strMasterCode + intMasterID.ToString() + intDetailID.ToString() + "UCL")
                    objSTBuilder.Append("' ")
                    objSTBuilder.Append(strCurrentStyle + ">")
                    objSTBuilder.Append("</INPUT>")
                    objSTBuilder.Append("</TD>")
                End If


                objSTBuilder.Append("<TD style='PADDING-LEFT: 30px'>")
                objSTBuilder.Append("<INPUT hideFocus ")
                objSTBuilder.Append(strSelect)
                objSTBuilder.Append(" type=checkbox name='")
                objSTBuilder.Append(strMasterCode + intMasterID.ToString() + "C")
                objSTBuilder.Append("' value='")
                If (intGridType = GridType.CONFIGURE_PROCESSES) Then
                    objSTBuilder.Append(intMasterID.ToString() + "-" + intDetailID.ToString())
                Else
                    objSTBuilder.Append(intDetailID.ToString())
                End If
                objSTBuilder.Append("'")
                If (intGridType = GridType.CONFIGURE_METRICES) Then
                    objSTBuilder.Append(" onclick='CheckChild(this)' ")
                End If
                objSTBuilder.Append(">")
                objSTBuilder.Append("</INPUT>")
                objSTBuilder.Append("</TD>")
                objSTBuilder.Append("</TR>")
            End If

        End While
        CommonFunction.Data.DisposeDataReader(objDataRow)
        objSTBuilder.Append("</TBODY>")
        objSTBuilder.Append("</TABLE>")

        objSTBuilder.Append("</DIV>")

        If (intGridType = GridType.CONFIGURE_PROCESSES) Then
            'Set the processes for the selected project type
            If (strAvailableMasters.Length > 0) Then txtProcesses.Text = strAvailableMasters.Substring(0, strAvailableMasters.Length - 1)
        Else
            'Set the processes for the selected project type
            If (strAvailableMasters.Length > 0) Then txtMetricCategories.Text = strAvailableMasters.Substring(0, strAvailableMasters.Length - 1)
        End If
        'flush the html
        Response.Write(objSTBuilder.ToString())
    End Sub

    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        'Insert or update project type depending upon the input
        Dim strSQL As String
        Dim strSelectedValues As String
        strSQL = "usp_ins_P12_ProjectType_Config " + m_intProjectTypeID.ToString + ","
        strSQL += "'" + CommonFunctions.General.BuildQueryString(txtProjectType.Text) + "',"
        strSQL += "'" + CommonFunctions.General.BuildQueryString(txtProjectTypeDescription.Text) + "',"
        strSQL += "1"
        m_intProjectTypeID = System.Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, True, m_strConnectionString))
        'Synchronize all list box
        'Synchronize_Lists(lstAvailablePlans, lstSelectedPlans)
        'Synchronize_Lists(lstAvailablePhases, lstSelectedPhases)
        'Synchronize_Lists(lstAvailableTaskTypes, lstSelectedTaskTypes)
        'Synchronize_Lists(lstAvailableIssueTypes, lstSelectedIssueTypes)
        'Synchronize_Lists(lstAvailableReviewTypes, lstSelectedReviewTypes)
        'Synchronize_Lists(lstAvailableCorporateRisks, lstSelectedCorporateRisks)

        'Insert or Update Project Type Plans Association
        'strSelectedValues = GetSelectedValues(lstSelectedPlans)
        strSelectedValues = ""
        If (txtSelectedPlans.Text <> "") Then
            strSelectedValues = txtSelectedPlans.Text
        End If

        If (strSelectedValues.Length > 0) Then
            strSQL = "usp_ins_ProjectType_P12_Plans_data " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "'" + strSelectedValues + "'"
        Else
            strSQL = "usp_ins_ProjectType_P12_Plans_data " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)

        'Insert or Update Project Type Plans Association
        'strSelectedValues = GetSelectedValues(lstSelectedPlans)
        strSelectedValues = ""
        If (txtSelectedIssueTypes.Text <> "") Then
            strSelectedValues = txtSelectedIssueTypes.Text
        End If

        If (strSelectedValues.Length > 0) Then
            strSQL = "usp_ins_ProjectType_P12_Issue_Type_data " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "'" + strSelectedValues + "'"
        Else
            strSQL = "usp_ins_ProjectType_P12_Issue_Type_data " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)


        'Insert or update project type phase association
        'strSelectedValues = GetSelectedValues(lstSelectedPhases)
        If (txtSelectedPhases.Text <> "") Then
            strSelectedValues = txtSelectedPhases.Text
        End If
        If (strSelectedValues.Length > 0) Then
            strSQL = "usp_ins_ProjectType_P12_Phase_data " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "'" + strSelectedValues + "'"
        Else
            strSQL = "usp_ins_ProjectType_P12_Phase_data " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)

        'Insert or update project type task type association
        'strSelectedValues = GetSelectedValues(lstSelectedTaskTypes)
        strSelectedValues = ""
        If (txtSelectedTaskTypes.Text <> "") Then
            strSelectedValues = txtSelectedTaskTypes.Text
        End If
        If (strSelectedValues.Length > 0) Then
            strSQL = "usp_Ins_Upd_P12_ProjectType_TaskType " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "'" + strSelectedValues + "'"
        Else
            strSQL = "usp_Ins_Upd_P12_ProjectType_TaskType " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)

        'Insert or update project type review type association
        'strSelectedValues = GetSelectedValues(lstSelectedReviewTypes)
        strSelectedValues = ""
        If (txtSelectedReviewTypes.Text <> "") Then
            strSelectedValues = txtSelectedReviewTypes.Text
        End If
        If (strSelectedValues.Length > 0) Then
            strSQL = "usp_ins_ProjectTypes_P12_ReviewTypes " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "'" + strSelectedValues + "'"
        Else
            strSQL = "usp_ins_ProjectTypes_P12_ReviewTypes " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)

        'Insert or update project type corporate risk

        'strSelectedValues = GetSelectedValues(lstSelectedCorporateRisks)
        strSelectedValues = ""
        If (txtSelectedCorporateRisks.Text <> "") Then
            strSelectedValues = txtSelectedCorporateRisks.Text
        End If
        If (strSelectedValues.Length > 0) Then
            strSQL = "usp_ins_ProjectTypes_P12_CorporateRisk " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "'" + strSelectedValues + "'"
        Else
            strSQL = "usp_ins_ProjectTypes_P12_CorporateRisk " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)

        'Insert or update project type activity mapping
        strSelectedValues = txtConfiguredActivities.Text
        If (strSelectedValues.Length > 0) Then
            strSQL = "usp_ins_ProjectType_P12_Activities " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "'" + CommonFunctions.General.BuildQueryString(strSelectedValues) + "'"
        Else
            strSQL = "usp_ins_ProjectType_P12_Activities " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)

        'Insert or Update Metrics associated with this Project Type
        strSelectedValues = txtConfiguredMetric.Text

        If (strSelectedValues.Length > 0) Then
            AssociateMetricsToProjectType(strSelectedValues)
        Else
            'if no matrics are selected then remove previously selected metrics
            strSQL = "usp_ins_ProjectType_P12_PMI_Metrics " + m_intProjectTypeID.ToString + ","
            strSQL = strSQL + "NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)

        Response.Write(("  <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
        Response.Write((" window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;" + Environment.NewLine))
        Response.Write((" window.parent.frames['WhizVisualProcessGrid'].document.location.href = 'WhizProjectType.aspx?ProjectTypeID=" + m_intProjectTypeID.ToString() + "';" + Environment.NewLine))
        Response.Write(" </script>")
    End Sub

    Private Sub AssociateMetricsToProjectType(ByVal strSelectedValues As String)
        Dim strSQL As String
        Dim strMetrics As String() = strSelectedValues.Split("|")

        For Each strMetricVal As String In strMetrics
            strSQL = "usp_ins_ProjectType_P12_PMI_Metrics " + m_intProjectTypeID.ToString + "," + strMetricVal
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)
        Next
    End Sub

    Protected Sub btnBottomCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBottomCancel.Click
        Response.Redirect("WhizProcessDetails.aspx?PKID=0|PT")
    End Sub

    Protected Sub btnCreatePublishTemplate_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strSQL As String
        Dim strRequestCode As String = "P12TLT"
        Dim strRequestActionCode As String = "I"
        Dim strRequestGUID As String = ""

        strSQL = "USP_INS_WHIZ_TO_P12_ENQUEUE "
        strSQL = strSQL + "'" + strRequestCode + "',"
        strSQL = strSQL + m_intProjectTypeID.ToString() + ","
        strSQL = strSQL + "'" + strRequestActionCode.ToString() + "',"
        If (strProjectTypeGUID = "") Then
            strSQL = strSQL + "NULL,"
        Else
            strSQL = strSQL + "'" + strProjectTypeGUID + "',"
        End If
        strSQL = strSQL + "'" + CommonFunctions.General.BuildQueryString(txtProjectType.Text) + "'"

        CommonFunctions.Data.InsertOrUpdateData(strSQL, True, m_strConnectionString)
    End Sub

End Class