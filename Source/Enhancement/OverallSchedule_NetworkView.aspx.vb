Imports Whizible
Imports System.Drawing
Imports System.Drawing.Imaging

Public Class OverallSchedule_NetworkView
    Inherits WebPages.Template.WhizTemplate
#Region "Member Variables"
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected m_objAccessRights As New WebPage.Templates.AccessRights
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Dim m_sbHTML As New StringBuilder
    Protected m_UniqueID As String
    Protected m_strProjectID As String
    Protected m_OverallScheduleID As String
    Protected m_strFromWhere As String
    Private objCascadedScoreCardDS As DataSet
    Dim CScoreCardHastable As Hashtable = New Hashtable()
    Dim intVerticalGapOfObject As Integer = 40    
    Dim intHorizentalGapOfObject As Integer = 40
    Dim intDrawStringSize As Integer = 50
    Dim strStartText As String = ""
    Dim fontBanner As Font
    Dim stringFormat As StringFormat
    Dim strNewFileName As String
    Dim adPitch As String = ""
    Dim intObjectWidth As Integer = 130
    Dim intObjectHieght As Integer = 50
    Dim intImgWidth As Integer = 995
    Dim intImgHeight As Integer = 400
    Dim objBitmap As Bitmap
    Dim objGraphics As Graphics
    Dim intPreStartX As Integer = 0
    Dim intPreEndX As Integer = 0
    Dim intImgPreStartX As Integer = 0
    Dim intImgPreEndX As Integer = 0
    Dim m_strSnapshotID As String = ""
    Dim m_intNoOfLevel As Integer = 7
    Dim m_level As Integer = 0
    Dim m_count As Integer = 1
    Dim CSImage As Image = Image.FromFile(Server.MapPath("../../Images/DB/down_DB.gif"))
    Dim ProjectImage As Image = Image.FromFile(Server.MapPath("../../Images/Calender Images/Pattern1.jpg"))
    Dim intCurrentLevel As Integer = 0
    Dim intSnapshotID As Integer = 0
    Protected strThresholdValue As String
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 25th-May-2016 to show Threshold Value on n/w diagram
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        '' strThresholdValue = CommonFunctions.Data.GetDataScalar("SELECT ISNULL(OSThresholdValue,'') FROM tbl_PM_CompanyInformation ", True)
        strThresholdValue = CommonFunctions.Data.GetDataScalar("usp_sel_OSThresholdValue_tbl_PM_CompanyInformation ", True)
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        'End of Added By Bharat Tekade on 25th-May-2016 to show Threshold Value on n/w diagram
    End Sub
    Protected Sub PageInit()

        m_strProjectID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("projectId")), "0")
        m_OverallScheduleID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("OverallScheduleID")), "0")
        m_strFromWhere = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("FromWhere")), "0")

        If m_strProjectID = "0" Then
            m_strProjectID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")
        End If
        intSnapshotID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_WPBN_PM_OverallScheduleMaster " & m_strProjectID, True), 0)

        If Not IsNothing(HttpContext.Current.Request.Form("cboSnapshot")) Then
            m_UniqueID = HttpContext.Current.Request.Form("cboSnapshot").ToString()
            m_UniqueID = m_UniqueID.Replace(",", "")

        End If
        If m_UniqueID = "" Then
            m_UniqueID = intSnapshotID.ToString()
        End If

        If m_strFromWhere.ToUpper = "PROJECT" Then
            objCascadedScoreCardDS = CommonFunctions.Data.GetDataSet("usp_sel_tbl_WPBN_PM_OverallSchedule_Network " + m_strProjectID + "," + m_UniqueID, "CascadedScoreCard")
            m_UniqueID = m_strProjectID
        ElseIf m_strFromWhere.ToUpper = "OSCOMBINATION" Then
            objCascadedScoreCardDS = CommonFunctions.Data.GetDataSet("usp_sel_tbl_WPBN_PM_OverallSchedule_OSCombination_Network " + m_OverallScheduleID, "CascadedScoreCard")
            m_UniqueID = m_OverallScheduleID
            ''PlotMenu()
        End If
        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            m_strProjectID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("ProjectID")), "0")
            m_OverallScheduleID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Request.QueryString("OSID")), "0")
            Call getToolTipInfo()
            Response.End()
        Else
            m_sbHTML.Append(PlotCascadedScoreCard().ToString())
        End If
        HttpContext.Current.Response.Write(m_sbHTML.ToString)



        m_sbHTML = Nothing
        Call DesposeObject()
    End Sub
    Private Sub getToolTipInfo()

        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String
        Dim TaskName As String
        Dim EmployeeName As String
        Dim StartDate As String
        Dim EndDate As String

        DivWidth = "100px"
        DivHt = "128px"

        strSQL = "Usp_sel_baseline_task_details ''," & m_OverallScheduleID.ToString & "," & m_strProjectID.ToString

        dr = CommonFunction.Data.GetDataReader(strSQL, True)

        sbHtml.Append("<Div id='divTaskDetails' style=""overflow:auto;POSITION: relative;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;"">")
        sbHtml.Append("<table id='tbl_Div' width='99.9%' CellPadding=0 CellSpacing=0 class=clsTable border=1>" + vbCrLf)
        sbHtml.Append("<TR class= clsTRColumnHeader>" + vbCrLf)
        sbHtml.Append("<TD  align='Left' colspan=3 ><B>Task Details</B></TD>" + vbCrLf)
        sbHtml.Append("<td align=right> | " + vbCrLf)
        sbHtml.Append("<a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a>" + vbCrLf)
        sbHtml.Append("</TD></TR><TR height='2px'><TD colspan=4></TD></TR>")

        'Header
        sbHtml.Append("<TR class='clsTRSectionHeader'>" + vbCrLf)
        sbHtml.Append("<TD  align='Center' ><B>Task Name</B></TD>" + vbCrLf)
        sbHtml.Append("<TD  align='Center' ><B>Employee Name</B></TD>" + vbCrLf)
        sbHtml.Append("<TD  align='Center' ><B>Start Date</B></TD>" + vbCrLf)
        sbHtml.Append("<TD  align='Center' ><B>End Date</B></TD>" + vbCrLf)
        sbHtml.Append("</TR>" + vbCrLf)

        While dr.Read
            TaskName = CType(dr("TaskName"), String)
            EmployeeName = CType(dr("ResourceName"), String)
            StartDate = CType(dr("CurrentStartDate"), String)
            EndDate = CType(dr("CurrentEndDate"), String)

            'Data
            sbHtml.Append("<TR class=clsTREven>" + vbCrLf)
            sbHtml.Append("<TD  align='Center' nowrap >" + TaskName + "</TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Center' nowrap >" + EmployeeName + "</TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Center' nowrap >" + StartDate + "</TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Center' nowrap >" + EndDate + "</TD>" + vbCrLf)

            sbHtml.Append("</TR>" + vbCrLf)
        End While

        sbHtml.Append("</Table>" + vbCrLf)
        sbHtml.Append("</Div>" + vbCrLf)
        CommonFunction.Data.DisposeDataReader(dr)
        Response.Write(sbHtml)
    End Sub
    Protected Sub PlotMenu()
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder

        Dim m_arrMenu() As String = {"Close"}
        Dim m_arrMenuToolTip() As String = {"Close"}
        Dim m_arrCSFunction() As String = {"Close_OnClick()"}
        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction

        Dim strMenu As String

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        sbSTRHTML.Append(strMenu)

        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())
        CommonFunction.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Network diagram", , , True))
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "", , , True))

        CommonFunction.General.WriteHTML("<br>")

    End Sub
    Private Function PlotFilterCorporateScoreCardComboBox() As StringBuilder
        Dim sbHTML As New StringBuilder
        Dim strSQL As String = ""
        Dim strSnapshotID As String = ""
        Dim strSQL1 As String = ""


        If Not IsNothing(HttpContext.Current.Request.Form("cboSnapshot")) Then
            strSnapshotID = HttpContext.Current.Request.Form("cboSnapshot").ToString()
            strSnapshotID = strSnapshotID.Replace(",", "")
        End If
        If strSnapshotID = "" Then
            strSnapshotID = intSnapshotID.ToString()
        End If

        strSQL = "usp_sel_tbl_WPBN_PM_OverallScheduleMaster " & m_strProjectID

        sbHTML.Append("<TABLE cellpadding='0px' cellspacing='0px' class='clsTable' width='100%'>")
        sbHTML.Append("<TR class='clsTRPageFilters'>")
        sbHTML.Append("<TD colspan=2 valign='top' align='left' >Project Schedule : ")
        If intSnapshotID <> 0 Then
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSnapshot", strSQL, 300, strSnapshotID, "onchange=Combo_onChange()", False, True, True))
        Else
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSnapshot", strSQL, 300, strSnapshotID, "onchange=Combo_onChange()", True, True, True))
        End If
        sbHTML.Append("</TD>")
        ''sbHTML.Append("<TD valign='top' align='left' colspan=2><a id='ancSaveSnapshot' class='clsSaveSnapshot' onclick='PrintNetwork()'>Print</a>")
        sbHTML.Append("</TR><TR class='clsTRPageFilters'>")
        'Added By Bharat Tekade on 25th-May-2016 to show s.v. formula
        sbHTML.Append("<TD style='width:50%;' rowspan=3 >Schedule variance=[(Actual End Date - Planned End Date) / (Planned End Date - Planned start Date) + 1] * 100 </TD>")
        'End of Added By Bharat Tekade on 25th-May-2016 to show s.v. formula
        sbHTML.Append("<TD valign='top' align='left' ><div style='width:30px;height:20px;border:1px solid #CCC;background-color:red'></div> Above Threshold [" & strThresholdValue & "]</TD>")
        sbHTML.Append("</TR><TR class='clsTRPageFilters'>")       
        sbHTML.Append("<TD valign='top' align='left' ><div style='width:30px;height:20px;border:1px solid #CCC;background-color:FFA500'></div> Between 0 to Threshold [0 to " & strThresholdValue & "]</TD>")
        sbHTML.Append("</TR><TR class='clsTRPageFilters'>")       
        sbHTML.Append("<TD valign='top' align='left' ><div style='width:30px;height:20px;border:1px solid #CCC;background-color:ADFF2F'></div> Below Threshold [" & strThresholdValue & "] </TD>")
        sbHTML.Append("</TR></TABLE>")

        If intSnapshotID = 0 Then
            sbHTML.Append("<div style=""overflow:auto;width:100%;"" ID=""PageDiv""")
            sbHTML.Append("<TABLE cellpadding='0px' cellspacing='0px' width='" + CStr(intImgWidth) + "px' align='center'>")
            sbHTML.Append("<TR >")
            sbHTML.Append("<TD align='center'>")
            sbHTML.Append("There are no snapshot taken.Please take the snapshot to view the network diagram.")
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR></TABLE>")
            sbHTML.Append("</div>")
        End If
        PlotFilterCorporateScoreCardComboBox = sbHTML
    End Function
    Private Function PlotFilterCorporateScoreCardLegends() As StringBuilder
        Dim sbHTML As New StringBuilder
        Dim strSQL As String = ""
        Dim strSnapshotID As String = ""



        sbHTML.Append("<TABLE cellpadding='0px' cellspacing='0px' class='clsTable' width='100%'>")
        sbHTML.Append("<TR class='clsTRPageFilters'>")
        'Added By Bharat Tekade on 25th-May-2016 to show s.v. formula
        sbHTML.Append("<TD style='width:50%;' rowspan=3 >Schedule variance=[(Actual End Date - Planned End Date) / (Planned End Date - Planned start Date) + 1] * 100 </TD>")
        'End of Added By Bharat Tekade on 25th-May-2016 to show s.v. formula
        sbHTML.Append("<TD valign='top' align='left' ><div style='width:30px;height:20px;border:1px solid #CCC;background-color:red'></div> Above Threshold [" & strThresholdValue & "]</TD>")
        sbHTML.Append("</TR><TR class='clsTRPageFilters'>")
        sbHTML.Append("<TD valign='top' align='left' ><div style='width:30px;height:20px;border:1px solid #CCC;background-color:FFA500'></div> Between 0 to Threshold [0 to" & strThresholdValue & "]</TD>")
        sbHTML.Append("</TR><TR class='clsTRPageFilters'>")
        sbHTML.Append("<TD valign='top' align='left' ><div style='width:30px;height:20px;border:1px solid #CCC;background-color:ADFF2F'></div> Below Threshold [" & strThresholdValue & "] </TD>")
        sbHTML.Append("</TR></TABLE>")

        PlotFilterCorporateScoreCardLegends = sbHTML
    End Function
    Private Function PlotCascadedScoreCard() As StringBuilder
        '=====================================================================
        ' Function  Name		:	PlotCascadedScoreCard()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To plot the cascaded scorecard.
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	Aniruddh Gujar
        ' Created				:	Apr 28 2016
        ' Revisions				:	
        '=====================================================================
        Dim sbHTML As New StringBuilder
        Dim strCascadedScoreCardID As String = ""
        Dim strScoreCardID As String = ""
        Dim strCScoreCardName As String = ""
        Dim strCSLevelID As String = ""
        Dim intParentCSX As Integer = 0
        Dim intParentCSY As Integer = CInt(intVerticalGapOfObject / 2)
        Dim intChildCSX As Integer = 0
        Dim intChildCSY As Integer = 0
        Dim intImgChildCSX As Integer = 0
        Dim intImgChildCSY As Integer = 0
        Dim blnIsActive As Boolean = True
        Dim strLabel As String
        Dim strColour As String = ""


        intChildCSY = intChildCSY + (intObjectHieght + intVerticalGapOfObject) + CInt(intVerticalGapOfObject / 2)
        intImgChildCSY = intImgChildCSY + (intObjectHieght + intVerticalGapOfObject) + CInt(intVerticalGapOfObject / 2)
        For Each objCascadedScoreCard As DataRow In objCascadedScoreCardDS.Tables(0).Select("Level = 1")
            strCascadedScoreCardID = objCascadedScoreCard("ID").ToString()
            m_UniqueID = strCascadedScoreCardID
        Next

        Dim intImageWidth As Integer = 0
        Dim intImageHieght As Integer = 0
        If (m_UniqueID <> "") Then
            For Each objCascadedScoreCard As DataRow In objCascadedScoreCardDS.Tables(0).Select("ID =" + m_UniqueID)
                strCascadedScoreCardID = objCascadedScoreCard("ID").ToString()
                Call GetImageWidthHieght(strCascadedScoreCardID, intImgChildCSX, intImgChildCSY, 2, 0)
                intImageWidth = (intImgPreStartX + ((intImgPreEndX + intObjectWidth) - intImgPreStartX)) + 20
            Next
        End If
        intImageHieght = (intCurrentLevel * intObjectHieght) + (intCurrentLevel * intVerticalGapOfObject)
        If (intImgHeight < intImageHieght) Then
            intImgHeight = intImageHieght
        End If
        If (intImgWidth < intImageWidth) Then
            intImgWidth = intImageWidth
        End If

        sbHTML.Append("<div style=""overflow:auto;width:100%;"" ID=""DivMain"" ")
        sbHTML.Append("<TABLE cellpadding='0px' cellspacing='0px' width='" + CStr(intImgWidth) + "px' align='center'>")
        sbHTML.Append("<TR>")
        sbHTML.Append("<TD class='clsTRSectionHeader align='left'>")
        If m_strFromWhere.ToUpper = "PROJECT" Then
            sbHTML.Append(PlotFilterCorporateScoreCardComboBox().ToString)
        ElseIf m_strFromWhere.ToUpper = "OSCOMBINATION" Then
            sbHTML.Append(PlotFilterCorporateScoreCardLegends().ToString)
        End If
        sbHTML.Append("</TD></TR></TABLE>")
        sbHTML.Append("</Div>")
        sbHTML.Append("<div style=""width:100%;height:700px;"" ID=""PageDiv""")

        sbHTML.Append("<TABLE cellpadding='0px' cellspacing='0px' width='" + CStr(intImgWidth) + "px' align='center'>")
        sbHTML.Append("<TR >")
        sbHTML.Append("<TD align='center'>")
        sbHTML.Append("<TABLE id='tblOrgMap' cellspacing='0' cellpadding='0' class='clsTable' >")
        If (intImageHieght = 0) Then
            intImageHieght = intImgHeight
        End If
        If (intImageWidth = 0) Then
            intImageWidth = intImgWidth
        End If
        objBitmap = New Bitmap(intImageWidth, intImageHieght)
        objGraphics = Graphics.FromImage(objBitmap)
        objGraphics.FillRectangle(New SolidBrush(Color.White), 0, 0, intImageWidth, intImageHieght)
        fontBanner = New Font("Arial", 9, FontStyle.Regular)
        stringFormat = New StringFormat()
        stringFormat.Alignment = StringAlignment.Center
        stringFormat.LineAlignment = StringAlignment.Center

        If (m_UniqueID <> "") Then
            For Each objCascadedScoreCard As DataRow In objCascadedScoreCardDS.Tables(0).Select("ID =" + m_UniqueID)
                strCascadedScoreCardID = objCascadedScoreCard("ID").ToString()
                strCScoreCardName = objCascadedScoreCard("Entity").ToString()
                strLabel = objCascadedScoreCard("Attribute").ToString()
                strColour = objCascadedScoreCard("Colour").ToString()

                ''                objGraphics.DrawString(strLabel, fontBanner, New SolidBrush(Color.Black), New RectangleF(0, m_level, 50, 50), stringFormat)
                objGraphics.FillRectangle(New SolidBrush(Color.FromArgb(235, 245, 251)), 0, 10, intImageWidth, intObjectHieght + 20)
                ''objGraphics.DrawImage(ProjectImage, New PointF(1000, 0))

                Call DrawChildCascadedScoreCard(objGraphics, strCascadedScoreCardID, intChildCSX, intChildCSY, 2, 0)
                Dim intCurrentLineCSX As Integer = intPreStartX + CInt(((intPreEndX + intObjectWidth) - intPreStartX) / 2)
                CScoreCardHastable.Add(strCascadedScoreCardID, CStr(intCurrentLineCSX - CInt(intObjectWidth / 2)) + "," + CStr(intParentCSY))
                objGraphics.FillRectangle(New SolidBrush(Color.Black), intCurrentLineCSX - CInt(intObjectWidth / 2), intParentCSY, intObjectWidth, intObjectHieght)
                If blnIsActive Then
                    If strColour = "Green" Then
                        objGraphics.FillRectangle(New SolidBrush(Color.GreenYellow), (intCurrentLineCSX - CInt(intObjectWidth / 2)) + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                    ElseIf strColour = "Red" Then
                        objGraphics.FillRectangle(New SolidBrush(Color.Red), (intCurrentLineCSX - CInt(intObjectWidth / 2)) + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                    ElseIf strColour = "Orange" Then
                        objGraphics.FillRectangle(New SolidBrush(Color.Orange), (intCurrentLineCSX - CInt(intObjectWidth / 2)) + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                    End If
                Else
                    objGraphics.FillRectangle(New SolidBrush(Color.LightGray), (intCurrentLineCSX - CInt(intObjectWidth / 2)) + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                End If
                If strCScoreCardName.Length > intDrawStringSize Then
                    strStartText = strCScoreCardName.Substring(0, intDrawStringSize) + "..."
                Else
                    strStartText = strCScoreCardName
                End If

                objGraphics.DrawString(strStartText, fontBanner, New SolidBrush(Color.Black), New RectangleF(intCurrentLineCSX - CInt(intObjectWidth / 2), intParentCSY, intObjectWidth, intObjectHieght), stringFormat)
                'objGraphics.DrawString("P", fontBanner, New SolidBrush(Color.Black), New RectangleF(intCurrentLineCSX + (intObjectWidth - 15) - CInt(intObjectWidth / 2), intParentCSY + 5, 10, 10), stringFormat)
                ''objGraphics.DrawImage(ProjectImage, New PointF(intCurrentLineCSX + (intObjectWidth - 15) - CInt(intObjectWidth / 2), intParentCSY + 5))
                'Added By Bharat Tekade on 24th-May-2016 to plot small rectangle to show caption 
                objGraphics.FillRectangle(New SolidBrush(Color.Black), intCurrentLineCSX - CInt(intObjectWidth / 2) + intObjectWidth, intParentCSY, 20, intObjectHieght)
                objGraphics.FillRectangle(New SolidBrush(Color.LightBlue), ((intCurrentLineCSX - CInt(intObjectWidth / 2)) + intObjectWidth), intParentCSY + 1, 19, intObjectHieght - 2)
                objGraphics.DrawString("P", fontBanner, New SolidBrush(Color.Black), New RectangleF(((intCurrentLineCSX - CInt(intObjectWidth / 2)) + intObjectWidth), intParentCSY, 15, intObjectHieght), stringFormat)
                'End of Added By Bharat Tekade on 24th-May-2016 to plot small rectangle to show caption 
            Next
        End If
        strNewFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
        objBitmap.Save(Server.MapPath("../../Images/OSNetworkView/" + strNewFileName + ".png"), ImageFormat.Png)
        sbHTML.Append("<TR>")
        sbHTML.Append("<TD align='center' >")
        sbHTML.Append("<img src ='../../Images/OSNetworkView/" + strNewFileName + ".png' usemap ='#planetmap' border='0'/>")
        sbHTML.Append("<map id ='planetmap' name='planetmap'>")

        Dim strCascadedFor As String = ""
        Dim strCascadedLevel As String = ""
        Dim strLevelText As String = ""
        Dim strAttribute As String = ""
        Dim strIsActive As String = ""
        Dim intIsActive As Integer = 0
        Dim strAttributeID As String = ""
        Dim strOSID As String = ""

        For Each objScoreCard As DataRow In objCascadedScoreCardDS.Tables(0).Rows
            strScoreCardID = objScoreCard("ID").ToString()
            strCScoreCardName = objScoreCard("Entity").ToString()
            strCSLevelID = objScoreCard("Level").ToString()
            strAttribute = objScoreCard("Attribute").ToString()
            strAttributeID = objScoreCard("AttributeID").ToString()
            strOSID = objScoreCard("OSID").ToString()

            Dim strKeyValue As String
            Dim strCoords As String()
            Dim intCSX As Integer
            Dim intCSY As Integer
            Dim title As String = ""
            title = strCScoreCardName
            If (strCSLevelID <> 1) Then
                title = title + vbCrLf + strLevelText
            End If

            If CScoreCardHastable.ContainsKey(strScoreCardID) Then
                strKeyValue = CScoreCardHastable.Item(strScoreCardID).ToString()
                strCoords = strKeyValue.Split(",")
                intCSX = strCoords(0) 
                intCSY = strCoords(1)
                If (strCSLevelID = 1) Then
                    If strAttribute = "Task" Then
                        ''sbHTML.Append("<area shape ='rect' title='" + strAttribute + "' coords ='" + CStr(intCSX) + "," + CStr(intCSY) + "," + CStr(intCSX + intObjectWidth) + "," + CStr(intCSY + intObjectHieght) + "' onclick =Javascript:ShowTaskDiv(event," + strOSID.ToString + "," + m_strProjectID + ") style='cursor: hand' alt='" + Microsoft.VisualBasic.Strings.Replace(title, "'", "&#39;") + "' />")  'alt='" + title + "' 
                        sbHTML.Append("<area shape ='rect' title='" + strAttribute + "' coords ='" + CStr(intCSX) + "," + CStr(intCSY) + "," + CStr(intCSX + intObjectWidth) + "," + CStr(intCSY + intObjectHieght) + "' onclick =Javascript:ShowTaskDetails(" + strOSID.ToString + ") style='cursor: hand' alt='" + Microsoft.VisualBasic.Strings.Replace(title, "'", "&#39;") + "' />")  'alt='" + title + "' 
                    Else
                        sbHTML.Append("<area shape ='rect' title='" + strAttribute + "' coords ='" + CStr(intCSX) + "," + CStr(intCSY) + "," + CStr(intCSX + intObjectWidth) + "," + CStr(intCSY + intObjectHieght) + "' onclick =Javascript:ShowPopup(" + strAttributeID.ToString + ",'" + strAttribute.ToString() + "') style='cursor: hand' alt='" + Microsoft.VisualBasic.Strings.Replace(title, "'", "&#39;") + "' />")  'alt='" + title + "' 
                    End If
                Else
                    If strAttribute = "Task" Then
                        ''sbHTML.Append("<area shape ='rect' title='" + strAttribute + "' coords ='" + CStr(intCSX) + "," + CStr(intCSY) + "," + CStr(intCSX + intObjectWidth) + "," + CStr(intCSY + intObjectHieght) + "' onclick =Javascript:ShowTaskDiv(event," + strOSID.ToString + "," + m_strProjectID + ") style='cursor: hand' alt='" + Microsoft.VisualBasic.Strings.Replace(title, "'", "&#39;") + "' />") 'alt='" + title + "' 
                        sbHTML.Append("<area shape ='rect' title='" + strAttribute + "' coords ='" + CStr(intCSX) + "," + CStr(intCSY) + "," + CStr(intCSX + intObjectWidth) + "," + CStr(intCSY + intObjectHieght) + "' onclick =Javascript:ShowTaskDetails(" + strOSID.ToString + ") style='cursor: hand' alt='" + Microsoft.VisualBasic.Strings.Replace(title, "'", "&#39;") + "' />") 'alt='" + title + "' 
                    Else
                        sbHTML.Append("<area shape ='rect' title='" + strAttribute + "' coords ='" + CStr(intCSX) + "," + CStr(intCSY) + "," + CStr(intCSX + intObjectWidth) + "," + CStr(intCSY + intObjectHieght) + "' onclick =Javascript:ShowPopup(" + strAttributeID.ToString + ",'" + strAttribute.ToString() + "') style='cursor: hand' alt='" + Microsoft.VisualBasic.Strings.Replace(title, "'", "&#39;") + "' />") 'alt='" + title + "' 
                    End If

                End If
            End If
        Next
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR></TABLE>")
        sbHTML.Append("</TD></TR></TABLE>")
        sbHTML.Append("</div>")
        PlotCascadedScoreCard = sbHTML
    End Function
    Private Function GetImageWidthHieght(ByVal strCascadedScorecardID As Integer, ByRef intImgChildCSX As Integer, ByRef intImgChildCSY As Integer, ByRef intImgChildLevel As Integer, ByRef intImgChildParentX As Integer)
        '=====================================================================
        ' Procedure Name		:	GetImageWidthHieght
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To get image width and hieght.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Aniruddh Gujar
        ' Created				:	28 Apr 2016
        ' Revisions				:	
        '=====================================================================
        Dim strCScoreCardID As String = ""
        Dim strCScoreCardName As String = ""
        Dim strCSLevelID As String = ""
        Dim intParentCSX As Integer = intImgChildCSX
        Dim intParentCSY As Integer = intImgChildCSY
        Dim intParentLevel As Integer = intImgChildLevel
        Dim intCount As Integer = 0
        Dim intStartCSX As Integer = 0
        Dim intStartCSY As Integer = 0
        Dim intEndCSX As Integer = 0
        Dim intEndCSY As Integer = 0


        For Each objCascadedChild As DataRow In objCascadedScoreCardDS.Tables(0).Select("ParentID = " + CStr(strCascadedScorecardID))
            strCScoreCardID = objCascadedChild("ID").ToString()

            If (IsChildExist(strCScoreCardID)) Then
                If intCount <> 0 Then
                    intImgChildCSY = intParentCSY
                End If
                intImgChildLevel += 1
                intImgChildCSY = intImgChildCSY + (intObjectHieght + intVerticalGapOfObject)
                Call GetImageWidthHieght(strCScoreCardID, intImgChildCSX, intImgChildCSY, intImgChildLevel, intImgChildParentX)
            Else
                intImgChildLevel = intParentLevel
            End If
            If intCount <> 0 Then
                If (intImgChildLevel = intParentLevel) Then
                    intImgChildCSX = intImgChildCSX + (intObjectWidth + intHorizentalGapOfObject)
                    intParentCSX = intParentCSX + intObjectWidth + intHorizentalGapOfObject
                Else
                    intParentCSX = intImgChildParentX
                    intImgChildLevel = intParentLevel
                    intParentCSX = intParentCSX + (CInt((intImgChildCSX - intParentCSX) / 2) - CInt(intObjectWidth / 2))
                End If
            Else
                intImgChildParentX = intParentCSX
                If (intImgChildLevel = intParentLevel) Then
                    intImgChildCSX = intImgChildCSX + (intObjectWidth + intHorizentalGapOfObject)
                Else
                    intParentCSX = intImgChildParentX
                    intImgChildLevel = intParentLevel
                    intParentCSX = intParentCSX + (CInt((intImgChildCSX - intParentCSX) / 2) - CInt(intObjectWidth / 2))


                End If
            End If
            If (intPreStartX = intPreEndX) Or (Not IsChildExist(strCScoreCardID)) Then
                If intCount = 0 Then
                    intStartCSX = intParentCSX
                    intStartCSY = intParentCSY
                End If
                intEndCSX = intParentCSX
                intEndCSY = intParentCSY
            Else

                Dim intCurrentCSX As Integer = (intImgPreStartX + CInt((intImgPreEndX + intObjectWidth + intHorizentalGapOfObject) - intImgPreStartX) / 2) - CInt(intObjectWidth / 2)
                If intCount = 0 Then
                    intStartCSX = intCurrentCSX
                    intStartCSY = intParentCSY
                End If
                intEndCSX = intCurrentCSX
                intEndCSY = intParentCSY

            End If
            intCount += 1
        Next

        If intImgChildLevel > intCurrentLevel Then
            intCurrentLevel = intImgChildLevel
        End If
        intImgPreStartX = intStartCSX
        If (intEndCSX > intImgPreEndX) Then
            intImgPreEndX = intEndCSX
        End If

    End Function
    Private Function IsChildExist(ByVal strCScoreCardID As String) As Boolean
        '=====================================================================
        ' Procedure Name		:	IsChildExist
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To check child exist or not.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Aniruddh Gujar
        ' Created				:	28 Apr 2016
        ' Revisions				:	
        '=====================================================================
        Dim intIsChildExist As Integer = objCascadedScoreCardDS.Tables(0).Select("ParentID = " + strCScoreCardID).Length
        If intIsChildExist <> 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    Private Function DrawChildCascadedScoreCard(ByRef objGraphics As Graphics, ByVal strCascadedScorecardID As Integer, ByRef intChildCSX As Integer, ByRef intChildCSY As Integer, ByRef intChildLevel As Integer, ByRef intChildParentX As Integer)
        '=====================================================================
        ' Procedure Name		:	DrawChildCascadedScoreCard
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To draw cascaded object.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	10 Dec 2007
        ' Revisions				:	
        '=====================================================================
        Dim strCScoreCardID As String = ""
        Dim strCScoreCardName As String = ""
        fontBanner = New Font("Arial", 9, FontStyle.Regular)
        stringFormat = New StringFormat()
        stringFormat.Alignment = StringAlignment.Center
        stringFormat.LineAlignment = StringAlignment.Center
        Dim intParentCSX As Integer = 0
        Dim intParentCSY As Integer = 0
        Dim intParentLevel As Integer = 0
        Dim intCount As Integer = 0
        intParentCSY = intChildCSY
        intParentCSX = intChildCSX
        intParentLevel = intChildLevel
        Dim intStartCSX As Integer = 0
        Dim intStartCSY As Integer = 0
        Dim intEndCSX As Integer = 0
        Dim intEndCSY As Integer = 0
        Dim strIsActive As String = ""
        Dim strShortName As String = ""
        Dim strColour As String = ""
        Dim strLabel As String
        Dim maxlevel As String

        Dim intImageWidth As Integer = 0
        intImageWidth = (intImgPreStartX + ((intImgPreEndX + intObjectWidth) - intImgPreStartX)) + 20
        If (intImgWidth < intImageWidth) Then
            intImgWidth = intImageWidth
        End If
        If (intImageWidth = 0) Then
            intImageWidth = intImgWidth
        End If
        For Each objCascadedChild As DataRow In objCascadedScoreCardDS.Tables(0).Select("ParentID = " + CStr(strCascadedScorecardID))
            strCScoreCardID = objCascadedChild("ID").ToString()
            strCScoreCardName = objCascadedChild("Entity").ToString()
            strShortName = objCascadedChild("ShortName").ToString()
            strColour = objCascadedChild("Colour").ToString()
            strLabel = objCascadedChild("Attribute").ToString()
            maxlevel = objCascadedChild("MaxLevel").ToString()

            If (IsChildExist(strCScoreCardID)) Then
                If intCount <> 0 Then
                    intChildCSY = intParentCSY
                End If
                intChildLevel += 1
                intChildCSY = intChildCSY + (intObjectHieght + intVerticalGapOfObject)

                Call DrawChildCascadedScoreCard(objGraphics, strCScoreCardID, intChildCSX, intChildCSY, intChildLevel, intChildParentX)
            Else
                intChildLevel = intParentLevel
            End If
            If intCount <> 0 Then
                If (intChildLevel = intParentLevel) Then
                    intChildCSX = intChildCSX + (intObjectWidth + intHorizentalGapOfObject)
                    intParentCSX = intParentCSX + intObjectWidth + intHorizentalGapOfObject
                Else
                    intParentCSX = intChildParentX
                    intChildLevel = intParentLevel
                    intParentCSX = intParentCSX + (CInt((intChildCSX - intParentCSX) / 2) - CInt(intObjectWidth / 2)) - (intHorizentalGapOfObject / 2)
                End If
            Else
                intChildParentX = intParentCSX
                If (intChildLevel = intParentLevel) Then
                    intChildCSX = intChildCSX + (intObjectWidth + intHorizentalGapOfObject)
                Else
                    intParentCSX = intChildParentX
                    intChildLevel = intParentLevel
                    'Commented and Added By Bharat Tekade on 24th-May-2016 to plot small rectangle
                    'intParentCSX = intParentCSX + (CInt((intChildCSX - intParentCSX) / 2) - CInt((intObjectWidth + 20) / 2))
                    intParentCSX = intParentCSX + (CInt((intChildCSX - intParentCSX) / 2) - CInt((intObjectWidth + 40) / 2))
                    'End of Commented and Added By Bharat Tekade on 24th-May-2016 to plot small rectangle
                End If
            End If

            If strCScoreCardName.Length > intDrawStringSize Then
                strStartText = strCScoreCardName.Substring(0, intDrawStringSize) + "..."
            Else
                strStartText = strCScoreCardName
            End If

            If m_count <= maxlevel Then
                m_level = m_level + intVerticalGapOfObject + 10
                ''objGraphics.DrawString(strLabel, fontBanner, New SolidBrush(Color.Black), New RectangleF(0, m_level, 70, 100), stringFormat)
                If strLabel = "SubProject" Then
                    objGraphics.FillRectangle(New SolidBrush(Color.FromArgb(253, 237, 236)), 0, intParentCSY - 10, intImageWidth, intObjectHieght + 20)
                ElseIf strLabel = "Module" Then
                    objGraphics.FillRectangle(New SolidBrush(Color.FromArgb(245, 238, 248)), 0, intParentCSY - 10, intImageWidth, intObjectHieght + 20)
                ElseIf strLabel = "MileStone" Then
                    objGraphics.FillRectangle(New SolidBrush(Color.FromArgb(234, 250, 241)), 0, intParentCSY - 10, intImageWidth, intObjectHieght + 20)
                ElseIf strLabel = "Deliverable" Then
                    objGraphics.FillRectangle(New SolidBrush(Color.FromArgb(254, 249, 231)), 0, intParentCSY - 10, intImageWidth, intObjectHieght + 20)
                ElseIf strLabel = "Phase" Then
                    objGraphics.FillRectangle(New SolidBrush(Color.FromArgb(254, 245, 231)), 0, intParentCSY - 10, intImageWidth, intObjectHieght + 20)
                ElseIf strLabel = "Task" Then
                    objGraphics.FillRectangle(New SolidBrush(Color.FromArgb(232, 246, 243)), 0, intParentCSY - 10, intImageWidth, intObjectHieght + 20)
                End If
                ''objGraphics.FillRectangle(New SolidBrush(Color.Gray), 0, m_level, intImageWidth, intObjectHieght + 10)
                m_level = m_level + intVerticalGapOfObject + 10
            End If
            m_count = m_count + 1

            If (intPreStartX = intPreEndX) Or (Not IsChildExist(strCScoreCardID)) Then

                If strIsActive = "False" Then
                    If strStartText <> "NA" Then
                        objGraphics.FillRectangle(New SolidBrush(Color.Black), intParentCSX, intParentCSY, intObjectWidth, intObjectHieght)
                        objGraphics.FillRectangle(New SolidBrush(Color.LightGray), intParentCSX + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                    End If
                Else
                    If strStartText <> "NA" Then
                        objGraphics.FillRectangle(New SolidBrush(Color.Black), intParentCSX, intParentCSY, intObjectWidth, intObjectHieght)
                        If strColour = "Green" Then
                            objGraphics.FillRectangle(New SolidBrush(Color.GreenYellow), intParentCSX + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                        ElseIf strColour = "Red" Then
                            objGraphics.FillRectangle(New SolidBrush(Color.Red), intParentCSX + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                        ElseIf strColour = "Orange" Then
                            objGraphics.FillRectangle(New SolidBrush(Color.Orange), intParentCSX + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                        End If
                    End If
                End If
                ''
                If strStartText <> "NA" Then
                    objGraphics.DrawString(strStartText, fontBanner, New SolidBrush(Color.Black), New RectangleF(intParentCSX, intParentCSY, intObjectWidth, intObjectHieght), stringFormat)
                    'objGraphics.DrawString(strShortName, fontBanner, New SolidBrush(Color.Black), New RectangleF(intParentCSX + (intObjectWidth - 15), intParentCSY + 5, 10, 10), stringFormat)
                End If

                'Added By Bharat Tekade on 24th-May-2016 to plot small rectangle to show caption 
                If strStartText <> "NA" Then
                    objGraphics.FillRectangle(New SolidBrush(Color.Black), intParentCSX + intObjectWidth, intParentCSY, 25, intObjectHieght)
                    objGraphics.FillRectangle(New SolidBrush(Color.LightBlue), intParentCSX + intObjectWidth, intParentCSY + 1, 24, intObjectHieght - 2)
                    objGraphics.DrawString(strShortName, fontBanner, New SolidBrush(Color.Black), New RectangleF(intParentCSX + intObjectWidth, intParentCSY, 24, intObjectHieght), stringFormat)
                End If
                'End of Added By Bharat Tekade on 24th-May-2016 to plot small rectangle to show caption 

                ''
                ''objGraphics.DrawString(strStartText, fontBanner, New SolidBrush(Color.Black), New RectangleF(intParentCSX, intParentCSY, intObjectWidth, intObjectHieght), stringFormat)
                ''objGraphics.DrawLine(New Pen(Color.Black), (intParentCSX + CInt(intObjectWidth / 2)), (intParentCSY), (intParentCSX + CInt(intObjectWidth / 2)), (intParentCSY - CInt(intVerticalGapOfObject / 2)))

                If strStartText <> "NA" Then
                    objGraphics.DrawImage(CSImage, New PointF(((intParentCSX + CInt(intObjectWidth / 2)) - 6), (intParentCSY) - 12))
                    objGraphics.DrawLine(New Pen(Color.Black), (intParentCSX + CInt(intObjectWidth / 2)), (intParentCSY), (intParentCSX + CInt(intObjectWidth / 2)), (intParentCSY - CInt(intVerticalGapOfObject / 2)))
                ElseIf strStartText = "NA" Then
                    objGraphics.DrawLine(New Pen(Color.Black), (intParentCSX + CInt(intObjectWidth / 2)), (intParentCSY + 50), (intParentCSX + CInt(intObjectWidth / 2)), (intParentCSY - CInt(intVerticalGapOfObject / 2)))
                End If


                ''objGraphics.DrawString(strShortName, fontBanner, New SolidBrush(Color.Black), New RectangleF(intParentCSX + (intObjectWidth - 15), intParentCSY + 5, 10, 10), stringFormat)
                CScoreCardHastable.Add(strCScoreCardID, CStr(intParentCSX) + "," + CStr(intParentCSY))
                If intCount = 0 Then
                    intStartCSX = intParentCSX
                    intStartCSY = intParentCSY
                End If
                intEndCSX = intParentCSX
                intEndCSY = intParentCSY


            Else
                '+ intHorizentalGapOfObject
                Dim intCurrentCSX As Integer = (intPreStartX + CInt((intPreEndX + intObjectWidth) - intPreStartX) / 2) - CInt(intObjectWidth / 2)

                If strIsActive = "False" Then
                    If strStartText <> "NA" Then
                        objGraphics.FillRectangle(New SolidBrush(Color.Black), intCurrentCSX, intParentCSY, intObjectWidth, intObjectHieght)
                        objGraphics.FillRectangle(New SolidBrush(Color.LightGray), intCurrentCSX + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                    End If
                Else
                    If strStartText <> "NA" Then
                        objGraphics.FillRectangle(New SolidBrush(Color.Black), intCurrentCSX, intParentCSY, intObjectWidth, intObjectHieght)
                        If strColour = "Green" Then
                            objGraphics.FillRectangle(New SolidBrush(Color.GreenYellow), intCurrentCSX + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                        ElseIf strColour = "Red" Then
                            objGraphics.FillRectangle(New SolidBrush(Color.Red), intCurrentCSX + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                        ElseIf strColour = "Orange" Then
                            objGraphics.FillRectangle(New SolidBrush(Color.Orange), intCurrentCSX + 1, intParentCSY + 1, intObjectWidth - 2, intObjectHieght - 2)
                        End If
                    End If
                End If

                If strStartText <> "NA" Then
                    objGraphics.DrawString(strStartText, fontBanner, New SolidBrush(Color.Black), New RectangleF(intCurrentCSX, intParentCSY, intObjectWidth, intObjectHieght), stringFormat)
                    'objGraphics.DrawString(strShortName, fontBanner, New SolidBrush(Color.Black), New RectangleF(intCurrentCSX + (intObjectWidth - 15), intParentCSY + 5, 10, 10), stringFormat)
                End If
                ''objGraphics.DrawString(strStartText, fontBanner, New SolidBrush(Color.Black), New RectangleF(intCurrentCSX, intParentCSY, intObjectWidth, intObjectHieght), stringFormat)
                ''objGraphics.DrawLine(New Pen(Color.Black), (intCurrentCSX + CInt(intObjectWidth / 2)), (intParentCSY), (intCurrentCSX + CInt(intObjectWidth / 2)), (intParentCSY - CInt(intVerticalGapOfObject / 2)))

                If strStartText <> "NA" Then
                    objGraphics.DrawImage(CSImage, New PointF(((intCurrentCSX + CInt(intObjectWidth / 2)) - 6), (intParentCSY) - 12))
                    objGraphics.DrawLine(New Pen(Color.Black), (intCurrentCSX + CInt(intObjectWidth / 2)), (intParentCSY), (intCurrentCSX + CInt(intObjectWidth / 2)), (intParentCSY - CInt(intVerticalGapOfObject / 2)))
                ElseIf strStartText = "NA" Then
                    objGraphics.DrawLine(New Pen(Color.Black), (intCurrentCSX + CInt(intObjectWidth / 2)), (intParentCSY + 50), (intCurrentCSX + CInt(intObjectWidth / 2)), (intParentCSY - CInt(intVerticalGapOfObject / 2)))
                End If
                ''objGraphics.DrawString(strShortName, fontBanner, New SolidBrush(Color.Black), New RectangleF(intCurrentCSX + (intObjectWidth - 15), intParentCSY + 5, 10, 10), stringFormat)
                CScoreCardHastable.Add(strCScoreCardID, CStr(intCurrentCSX) + "," + CStr(intParentCSY))
                If intCount = 0 Then
                    intStartCSX = intCurrentCSX
                    intStartCSY = intParentCSY
                End If
                intEndCSX = intCurrentCSX
                intEndCSY = intParentCSY

            End If
            intCount += 1


        Next
        Dim intCurrentLineCSX As Integer = intStartCSX + CInt(((intEndCSX + intObjectWidth) - intStartCSX) / 2)
        objGraphics.DrawLine(New Pen(Color.Black), (intStartCSX + CInt(intObjectWidth / 2)), (intStartCSY - CInt(intVerticalGapOfObject / 2)), (intEndCSX + CInt(intObjectWidth / 2)), (intEndCSY - CInt(intVerticalGapOfObject / 2)))
        objGraphics.DrawLine(New Pen(Color.Black), (intCurrentLineCSX), (intStartCSY - CInt(intVerticalGapOfObject / 2)), intCurrentLineCSX, (intStartCSY - CInt(intVerticalGapOfObject)))

        intPreStartX = intStartCSX
        intPreEndX = intEndCSX


    End Function
    Private Sub DesposeObject()
        objCascadedScoreCardDS.Dispose()
        CScoreCardHastable = Nothing
        objBitmap = Nothing
        objGraphics = Nothing
    End Sub
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()
    End Sub

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
    End Sub
End Class

