Public Partial Class MyToDoList
    Inherits WebPages.Template.WhizTemplate
    Protected m_strUserID As String = "0"
    Protected m_strUserName As String = ""
    Protected m_strAction As String = ""
    Protected m_intTotalRecords As Integer = 0
    Protected m_dsToDoList As DataSet
    Protected m_strDuration As String = ""
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected m_strEntityType As String = "ALL"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub
    Private Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()
        ' Purpose               : To Initialize the Variables
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 30-March-2009
        ' Revisions             :
        '=====================================================================
        m_strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "")
        m_strUserName = CommonFunctions.General.BuildQueryString(m_strUserName)
        m_strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
        m_strAction = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action")).ToString()

        m_strEntityType = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EntityType")).ToString()
        If m_strEntityType.ToUpper() = "" Then
            m_strEntityType = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtEntityType")).ToString()
        End If
        If m_strEntityType = "" Then
            m_strEntityType = "ALL"
        End If
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtEntityType", "txtEntityType", , , , m_strEntityType, , , , , , True, , True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtEntityType", "txtEntityType", , , , m_strEntityType, , , , , , True, , True, EnableHTMLEncode:=True))

        m_strDuration = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboDuration"), "")
        If m_strDuration = "" Then
            m_strDuration = "NULL"
        End If



        m_dsToDoList = CommonFunctions.Data.GetDataSet("Usp_Sel_TBL_PM_FLAGFORTRACKING_ToDoList " + m_strUserID, "MyToDoList")
        If Not m_dsToDoList Is Nothing Then

            If m_strEntityType.ToUpper() = "ALL" Then
                m_intTotalRecords = m_dsToDoList.Tables(0).Select(IIf(m_strDuration <> "NULL", " DueDateStatus = '" + m_strDuration + "' ", " 1=1 ").ToString()).Length
            Else
                m_intTotalRecords = m_dsToDoList.Tables(0).Select(IIf(m_strDuration <> "NULL", " DueDateStatus = '" + m_strDuration + "' ", " 1=1 ").ToString() + IIf(m_strEntityType <> "", " AND ContextTypeChar='" + m_strEntityType.ToUpper() + "'", "").ToString()).Length
            End If

        End If
    End Sub

    Public Sub WritePage()


        '=====================================================================
        ' Procedure Name		:	WritePage
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To write the page.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	 30-March-2009
        ' Revisions				:	
        '=====================================================================
        Call InitVariables()
        Dim intEntityCount As Integer = 0
        Dim strEntityName As String = ""
        'CommonFunctions.General.WriteHTML(InitializeMenu())

        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='overflow:auto;height=100%;Width:100%;'>")
        CommonFunctions.General.WriteHTML("<DIV id='FilterDiv' style='overflow:auto;height=16%;Width:100%;'>")
        CommonFunctions.General.WriteHTML("<BR><TABLE id='tblPageCap'  cellspacing=0 cellpadding=0 Width='100%'  class=clsTable>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRBlankNEW'>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='10%'><b>To Do</b></TD>")
        CommonFunctions.General.WriteHTML("<TD align=right width='90%'>")
        CommonFunctions.General.WriteHTML("<TABLE  Width='100%' cellspacing=0 class=clsTable ><TR class='clsTRBlankNEW'>")
        CommonFunctions.General.WriteHTML("<TD align=right>")
        intEntityCount = m_dsToDoList.Tables(0).Rows.Count
        If m_strEntityType.ToUpper() = "ALL" Then
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/WF_Process.gif'  title='All' style='CURSOR: hand;' onclick='javascript:EntityFilter(""ALL"")'> <b>ALL(" + intEntityCount.ToString() + ")</b> ")
        Else
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/WF_Process.gif'  title='All Request' style='CURSOR: hand;' onclick='javascript:EntityFilter(""ALL"")'> ALL(" + intEntityCount.ToString() + ") ")
        End If
        intEntityCount = m_dsToDoList.Tables(0).Select("ContextTypeChar='D'").Length
        If m_strEntityType.ToUpper() = "D" Then
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/D.gif'  title='Deliverable' style='CURSOR: hand;' onclick='javascript:EntityFilter(""D"")'> <b>Deliverable(" + intEntityCount.ToString() + ")</b> ")
        Else
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/D.gif'  title='Deliverable' style='CURSOR: hand;' onclick='javascript:EntityFilter(""D"")'> Deliverable(" + intEntityCount.ToString() + ") ")
        End If
        intEntityCount = m_dsToDoList.Tables(0).Select("ContextTypeChar='H'").Length
        If m_strEntityType.ToUpper() = "H" Then
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/H.gif'  title='Help Request' style='CURSOR: hand;' onclick='javascript:EntityFilter(""H"")'> <b>Help Request(" + intEntityCount.ToString() + ")</b> ")
        Else
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/H.gif'  title='Help Request' style='CURSOR: hand;' onclick='javascript:EntityFilter(""H"")'> Help Request(" + intEntityCount.ToString() + ") ")
        End If
        intEntityCount = m_dsToDoList.Tables(0).Select("ContextTypeChar='I'").Length
        If m_strEntityType.ToUpper() = "I" Then
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/I.gif'  title='Issue' style='CURSOR: hand;' onclick='javascript:EntityFilter(""I"")'> <b>Issue(" + intEntityCount.ToString() + ")</b> ")
        Else
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/I.gif'  title='Issue' style='CURSOR: hand;' onclick='javascript:EntityFilter(""I"")'> Issue(" + intEntityCount.ToString() + ") ")
        End If
        intEntityCount = m_dsToDoList.Tables(0).Select("ContextTypeChar='M'").Length
        If m_strEntityType.ToUpper() = "M" Then
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/M.gif'  title='Milestone' style='CURSOR: hand;' onclick='javascript:EntityFilter(""M"")'> <b>Milestone(" + intEntityCount.ToString() + ")</b> ")
        Else
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/M.gif'  title='Milestone' style='CURSOR: hand;' onclick='javascript:EntityFilter(""M"")'> Milestone(" + intEntityCount.ToString() + ") ")
        End If
        'intEntityCount = m_dsToDoList.Tables(0).Select("ContextTypeChar='R'").Length
        'If m_strEntityType.ToUpper() = "R" Then
        '    CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/R.gif'  title='Risk' style='CURSOR: hand;' onclick='javascript:EntityFilter(""R"")'> <b>Risk(" + intEntityCount.ToString() + ")</b> ")
        'Else
        '    CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/R.gif'  title='Risk' style='CURSOR: hand;' onclick='javascript:EntityFilter(""R"")'> Risk(" + intEntityCount.ToString() + ") ")
        'End If
        intEntityCount = m_dsToDoList.Tables(0).Select("ContextTypeChar='T'").Length
        If m_strEntityType.ToUpper() = "T" Then
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/T.gif'  title='Task' style='CURSOR: hand;' onclick='javascript:EntityFilter(""T"")'> <b>Task(" + intEntityCount.ToString() + ")</b> ")
        Else
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/T.gif'  title='Task' style='CURSOR: hand;' onclick='javascript:EntityFilter(""T"")'> Task(" + intEntityCount.ToString() + ") ")
        End If
        intEntityCount = m_dsToDoList.Tables(0).Select("ContextTypeChar='W'").Length
        If m_strEntityType.ToUpper() = "W" Then
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/W.gif'  title='Review' style='CURSOR: hand;' onclick='javascript:EntityFilter(""W"")'> <b>Review(" + intEntityCount.ToString() + ")</b> ")
        Else
            CommonFunctions.General.WriteHTML("<IMG Border=0  SRC='../../Images/W.gif'  title='Review' style='CURSOR: hand;' onclick='javascript:EntityFilter(""W"")'> Review(" + intEntityCount.ToString() + ") ")
        End If
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE></TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR></TABLE>")

        Call DrawFilter()
        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML("<table id='tblGrid032' width='99.9%' CellSpacing=1 CellPadding=0  class='clsGridTable' >")
        CommonFunctions.General.WriteHTML("<TR class='clsTRBlankNEW'>")
        CommonFunctions.General.WriteHTML("<TD  width='5%' align='Left' nowrap ><b>Flag</b></TD>")
        CommonFunctions.General.WriteHTML("<TD  width='8%' align='center' nowrap ><b>ID</b></TD>")
        CommonFunctions.General.WriteHTML("<TD  width='4%' align='Left' nowrap >&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD  width='20%' align='left' nowrap ><b>Project Name</b></TD>")
        CommonFunctions.General.WriteHTML("<TD  width='22%' align='left' nowrap ><b>Name</b></TD>")
        CommonFunctions.General.WriteHTML("<TD  width='17%' align='Left' nowrap ><b>Resource/Customer</b></TD>")
        CommonFunctions.General.WriteHTML("<TD  width='9%' align=left><b>Status</b></TD>")
        CommonFunctions.General.WriteHTML("<TD  width='10%' align=left><b>Due Date</b></TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='overflow:auto;height=80%;Width:100%;'>")
        Call PlotMyToDoListGrid()
        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML("<BR><TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRBlankNEW'>")
        CommonFunctions.General.WriteHTML("<TD  width='100%' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records : ")
        CommonFunctions.General.WriteHTML(m_intTotalRecords.ToString)
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

        'CommonFunctions.General.WriteHTML(InitializeMenu())

    End Sub
    Private Sub PlotMyToDoListGrid()
        '=====================================================================
        ' Procedure Name		:	PlotMyToDoListGrid
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plote the my to do list Grid.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	30-March-2009
        ' Revisions				:	
        '=====================================================================

        Dim strActivityType As String = ""
        Dim strPreActivityType As String = ""
        Dim Contextid As String = "0"
        Dim Projectid As String = "0"
        Dim Employeeid As String = "0"
        Dim Contexttype As String = "0"
        Dim EntityName As String = ""
        Dim Flag As String = ""
        Dim ContextC As String = ""
        Dim EID As String = "0"
        Dim strPKToken As String = ""
        Dim strEmployeeName As String = ""
        Dim strProjectName As String = ""
        Dim strDueDate As String = ""
        Dim strStatus As String = ""
        Dim strDueDateState As String = ""
        Dim strTRCss As String = ""
        Dim intCount As Integer = 0
        Dim strActivityTypeID As String = ""





        If m_intTotalRecords <> 0 Then
            For Each drToDoList As DataRow In m_dsToDoList.Tables(0).Select(IIf(m_strDuration <> "NULL", " DueDateStatus = '" + m_strDuration + "' ", " 1=1 ").ToString() + IIf(m_strEntityType <> "" And m_strEntityType <> "ALL", " AND ContextTypeChar='" + m_strEntityType.ToUpper() + "'", "").ToString())
                strActivityType = CommonFunctions.Data.CheckIsDBNull(drToDoList("DueDateStatus"), "6. Older")
                Contextid = CType(CommonFunctions.Data.CheckIsDBNull(drToDoList("Contextid"), "0"), String)
                Projectid = CType(CommonFunctions.Data.CheckIsDBNull(drToDoList("Projectid"), "0"), String)
                Employeeid = CType(CommonFunctions.Data.CheckIsDBNull(drToDoList("Employeeid"), "0"), String)
                Contexttype = CType(CommonFunctions.Data.CheckIsDBNull(drToDoList("Contexttype"), "0"), String)
                ContextC = CType(CommonFunctions.Data.CheckIsDBNull(drToDoList("ContextTypeChar"), ""), String)
                EID = CType(CommonFunctions.Data.CheckIsDBNull(drToDoList("ID"), "0"), String)
                strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drToDoList("EmployeeName"), "")
                strProjectName = CommonFunctions.Data.CheckIsDBNull(drToDoList("ProjectName"), "")
                strDueDate = CommonFunctions.Data.CheckIsDBNull(drToDoList("DueDate"), "")
                strStatus = CommonFunctions.Data.CheckIsDBNull(drToDoList("Status"), "")
                strDueDateState = CommonFunctions.Data.CheckIsDBNull(drToDoList("DueDateState"), "")
                EntityName = ""
                strActivityTypeID = CommonFunctions.Data.CheckIsDBNull(drToDoList("DueDateStatusID"))
                Flag = "Flag"
                If CType(CommonFunctions.Data.CheckIsDBNull(drToDoList("FlagTo"), "0"), String) = "1" Then
                    Flag = "Review"
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(drToDoList("FlagTo"), "2"), String) = "0" Then
                    Flag = "Follow Up"
                End If

                If intCount Mod 2 = 0 Then
                    strTRCss = "clsTRBlank"
                Else
                    strTRCss = "clsTRBlank"
                End If
                If strActivityType <> strPreActivityType Then
                    If intCount <> 0 Then
                        CommonFunctions.General.WriteHTML("</table>")
                        CommonFunctions.General.WriteHTML("</div>")
                    End If

                    Dim cObjFilterDetails As New WebPage.Templates.SectionTitle
                    With cObjFilterDetails
                        Response.Write("<B>" + .GetSectionTitle("<B>" + strActivityType + "</B>", "DivSection" + strActivityTypeID, "ShowHideGrid" + strActivityTypeID, "clsTRBlankNEW"))
                        Response.Write("<SCRIPT Language=javascript>")
                        Response.Write(.ClientsideScript)
                        Response.Write("</SCRIPT>")
                    End With
                    CommonFunctions.General.WriteHTML("<div ID='DivSection" + strActivityTypeID + "' style='overflow:auto;width:100%;' >")
                    CommonFunctions.General.WriteHTML("<table id='tblGridSection" + strActivityTypeID + "' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")

                    'CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader' valign=top>")
                    'CommonFunctions.General.WriteHTML("<TD colspan='9' ><b>")
                    'CommonFunctions.General.WriteHTML(strActivityType)
                    'CommonFunctions.General.WriteHTML("</b></TD>")
                    'CommonFunctions.General.WriteHTML("</tr>")
                End If

                CommonFunctions.General.WriteHTML("<tr class='" + strTRCss + "' valign=top>")

                If strDueDateState = "S" Then
                    CommonFunctions.General.WriteHTML("<TD width='5%'><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + Flag + "' onclick="""" ></a></TD>")
                ElseIf strDueDateState = "L" Then
                    CommonFunctions.General.WriteHTML("<TD width='5%'><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/RedFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>")
                ElseIf strDueDateState = "G" Then
                    CommonFunctions.General.WriteHTML("<TD width='5%'><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/GreenFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>")
                ElseIf strDueDateState = "B" Then
                    CommonFunctions.General.WriteHTML("<TD width='5%'><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/BlackFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>")
                ElseIf strDueDateState = "" Then
                    CommonFunctions.General.WriteHTML("<TD width='5%'><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/GrayFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>")
                End If

                If EID <> "0" Then
                    If ContextC = "H" Then
                        strPKToken = CommonFunctions.Security.Token.GetToken(EID + m_strUserID + "0" + "0")
                        CommonFunctions.General.WriteHTML("<TD width='8%' align=Center> <A HREF=""JAVASCRIPT:openHelpDeskReq('" + EID + "','" + strPKToken + "')""> " + EID + "</A> </TD>")
                    ElseIf ContextC = "T" Then
                        CommonFunctions.General.WriteHTML("<TD width='8%' align=Center> <A HREF=""JAVASCRIPT:openTaskReq('" + Projectid + "','" + EID + "')""> " + EID + "</A> </TD>")
                    Else
                        CommonFunctions.General.WriteHTML("<TD width='8%' align=Center> " + EID + " </TD>")
                    End If
                Else
                    CommonFunctions.General.WriteHTML("<TD width='8%' align=Center> - </TD>")
                End If

                Select Case ContextC
                    Case "D"
                        CommonFunctions.General.WriteHTML("<TD width='4%'><IMG Border=0  SRC='../../Images/D.gif'  title='Deliverable' ></A></TD>")
                    Case "H"
                        CommonFunctions.General.WriteHTML("<TD width='4%'><IMG Border=0  SRC='../../Images/H.gif'  title='Help Request' ></A></TD>")
                    Case "I"
                        CommonFunctions.General.WriteHTML("<TD width='4%'><IMG Border=0  SRC='../../Images/I.gif'  title='Issue' ></A></TD>")
                    Case "M"
                        CommonFunctions.General.WriteHTML("<TD width='4%'><IMG Border=0  SRC='../../Images/M.gif'  title='Milestone' ></A></TD>")
                    Case "R"
                        CommonFunctions.General.WriteHTML("<TD width='4%'><IMG Border=0  SRC='../../Images/R.gif'  title='Risk' ></A></TD>")
                    Case "T"
                        CommonFunctions.General.WriteHTML("<TD width='4%'><IMG Border=0  SRC='../../Images/T.gif'  title='Task' ></A></TD>")
                    Case "W"
                        CommonFunctions.General.WriteHTML("<TD width='4%'><IMG Border=0  SRC='../../Images/W.gif'  title='Review' ></A></TD>")
                End Select

                CommonFunctions.General.WriteHTML("<TD width='20%'>")
                If strProjectName <> "" Then
                    CommonFunctions.General.WriteHTML(strProjectName)
                Else
                    CommonFunctions.General.WriteHTML("N/A")
                End If
                CommonFunctions.General.WriteHTML("</TD>")

                EntityName = CommonFunctions.Data.CheckIsDBNull(drToDoList("EntityName"), "")


                CommonFunctions.General.WriteHTML("<TD width='22%'  align=Left >")
                If EntityName <> "" Then
                    CommonFunctions.General.WriteHTML(Server.HtmlEncode(EntityName))
                Else
                    CommonFunctions.General.WriteHTML("-")
                End If

                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD width='17%'  align=Left >")
                If strEmployeeName <> "" Then
                    CommonFunctions.General.WriteHTML(strEmployeeName)
                Else
                    CommonFunctions.General.WriteHTML("-")
                End If
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD  width='9%' align=Left >")
                If strStatus <> "" Then
                    CommonFunctions.General.WriteHTML(strStatus)
                Else
                    CommonFunctions.General.WriteHTML("-")
                End If
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD width='10%'  align=Left >")
                If strDueDate <> "" Then
                    CommonFunctions.General.WriteHTML(CommonFunctions.Dates.GetDate(strDueDate))
                Else
                    CommonFunctions.General.WriteHTML("-")
                End If
                CommonFunctions.General.WriteHTML("</TD>")


                CommonFunctions.General.WriteHTML("</TR> ")
                strPreActivityType = strActivityType
                intCount += 1
            Next
            If intCount <> 0 Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</div>")
            End If


        End If
        If intCount = 0 Then
            CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'>")
            CommonFunctions.General.WriteHTML("<TR >")
            CommonFunctions.General.WriteHTML("<TD class='clsTDBlankNew' width='99.99%' align='center'>")
            CommonFunctions.General.WriteHTML("There are no items to show in this view.")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")
        End If
        m_intTotalRecords = intCount
        intCount = 0

    End Sub
    Private Function InitializeMenu() As String
        '=====================================================================
        ' Procedure Name		:	InitializeMenu
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plote the page Menu.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	30-March-2009
        ' Revisions				:	
        '=====================================================================
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""


        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('MyToDoList')")


        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing
        m_objMenu = New WebPage.Templates.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        m_objMenu = Nothing
        Return strMenu
    End Function
    Protected Sub DrawFilter()
        '=====================================================================
        ' Procedure Name		:	DrawFilter
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plote the page filter.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	30-March-2009
        ' Revisions				:	
        '=====================================================================
        Dim intRecordCountDurationWise As Integer = 0
        Dim drDuration As IDataReader
        Dim strTotalFor As String = ""
        drDuration = CommonFunctions.Data.GetDataReader("usp_Sel_DurationFilter", MyBase.UseSQL)
        While drDuration.Read()
            intRecordCountDurationWise = m_dsToDoList.Tables(0).Select("DueDateStatus = '" + CommonFunctions.Data.CheckIsDBNull(drDuration("Comp")) + "'").Length
            If strTotalFor <> "" Then
                strTotalFor = strTotalFor + "," + CommonFunctions.Data.CheckIsDBNull(drDuration("Disp")) + "(" + intRecordCountDurationWise.ToString() + ")"
            Else
                strTotalFor = strTotalFor + CommonFunctions.Data.CheckIsDBNull(drDuration("Disp")) + "(" + intRecordCountDurationWise.ToString() + ")"
            End If
        End While
        CommonFunction.Data.DisposeDataReader(drDuration)
        CommonFunctions.General.WriteHTML("<BR><TABLE id='tblPageFilter' CellSpacing=0 BORDER=0 class='clsTable' width='100%'>")
        CommonFunctions.General.WriteHTML("<TR align=Left class='clsTRBlankNEW'>")
        CommonFunctions.General.WriteHTML("<TD width='35%'  align=center >Duration&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboDuration", "usp_Sel_DurationFilter ", 100, m_strDuration, "onchange=javascript:Duration_OnChange()", True, True))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD  width='65%' align=right >")
        CommonFunctions.General.WriteHTML("<b>Total for :</b> " + strTotalFor + "")
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table><BR>")
    End Sub
End Class