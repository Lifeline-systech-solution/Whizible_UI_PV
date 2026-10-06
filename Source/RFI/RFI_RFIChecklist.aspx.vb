'=====================================================================
' Module Name       :   RFI_RFIChecklist
' Purpose           :   Displays the Checklist For RFI Submission
' Description       :   Same as above
' Dependencies      :   None
' Author            :   DipaliS
' Created           :   July 30, 2004
' Revisions         :
'=====================================================================
Public Class RFI_RFIChecklist
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Constants"
    Private Const RFI_STATUS_DRAFT As String = "Draft"
    Private Const RFI_STATUS_REJECTED As String = "Rejected"
    Private Const RFI_INITIATOR As String = "Initiator"
#End Region

#Region "Member Variables"


    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
    Protected m_strToken As String
    'End of addition by MonikaI
    Protected m_intRFIID As Integer       ' The RFI ID.
    Private m_intProjectID As Long     ' The Project ID.
    Private m_intChecklistID As Integer     ' The RFI Checklist ID.
    Private m_intChecklistInstanceID As Integer  ' The RFI Checklist Instance ID.	
    Private m_intChecklistItemID As Integer  ' The Checklist Item ID.
    Private m_blnDeviationFound As Boolean  ' Flag indicating whether deviation was found in the checklist instance.	
    Private m_intChecklistInstanceItemID As Integer ' The Checklist Instance Item ID.
    Private m_blnReadOnly As Boolean    ' Flag indicating whether the checklist details can be edited.
    Private m_strAction As String
    Private m_intSubmitRFI As Integer
    Private m_strSeperator As String = ","
    Private m_charSep() As Char = m_strSeperator.ToCharArray
    Private m_strCheckListItemIDs As String
    Private m_strChecklistInstanceItemIDs As String
    Private m_strCheckListItemID() As String
    Private m_strChecklistInstanceItemID() As String
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    Protected m_intCounter As Integer
    Private m_strFromList As String = ""
    Private m_strResubmit As String = ""
    Private m_strtoken1 As String = ""


#End Region

#Region "Member Functions"

    Public Sub PageInit()
        '######### Page Code starts here
        Dim strSQLQuery As String
        'INITIALIZATIONS.
        ' -----------------		
        ' Get the action to be performed (VIEW/SAVE/DELETE).
        If Trim(Request.QueryString("Action")) <> "" Then
            m_strAction = Trim(Request.QueryString("Action"))
        Else
            m_strAction = "View"
        End If


        ' Get the RFIID.
        If Request.Form("txtUseFormContents") = "" Then

            m_blnReadOnly = False

            ' Get the RFI ID.
            m_intRFIID = CType(Request.QueryString("RFIID"), Integer)

            ' Get the RFI details.	

            Dim drDetails As IDataReader
            strSQLQuery = "Exec usp_Sel_tbl_PM_RFIs " & m_intRFIID.ToString
            drDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drDetails.Read Then
                m_intProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("ProjectID"), "0"), Long)
                m_intChecklistID = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("ChecklistID"), "0"), Integer)
                m_intChecklistInstanceID = CType(CommonFunctions.Data.CheckIsDBNull(drDetails.Item("ChecklistInstanceID"), "0"), Integer)

            End If
            CommonFunctions.Data.DisposeDataReader(drDetails)

            m_intSubmitRFI = CType(Request.QueryString("SubmitRFI"), Integer)
            m_strFromList = Trim(Request.QueryString("FromList"))
            m_strResubmit = Trim(Request.QueryString("ReSubmit"))

        Else

            m_intRFIID = CType(MyBase.GetFormValue("txtRFIID"), Integer)
            m_intProjectID = CType(MyBase.GetFormValue("txtProjectID"), Long)
            m_intChecklistID = CType(MyBase.GetFormValue("txtChecklistID"), Integer)
            m_intChecklistInstanceID = CType(MyBase.GetFormValue("txtChecklistInstanceID"), Integer)

            m_intSubmitRFI = CType(MyBase.GetFormValue("txtSubmitRFI"), Integer)
            m_strFromList = MyBase.GetFormValue("txtFromList")
            m_strResubmit = MyBase.GetFormValue("txtResubmit")
        End If

        '=====================================================================
        '	SAVE THE CHECKLIST THAT WAS FILLED BY THE USER.
        '=====================================================================	
        If m_strAction.ToUpper = "SAVE" Then

            ' STEP 1: Create a master entry for the checklist instance.	
            strSQLQuery = "Exec usp_Ins_tbl_PM_RFIChecklistInstances "

            ' Checklist Instance ID.
            If m_intChecklistInstanceID <> 0 Then
                strSQLQuery = strSQLQuery & m_intChecklistInstanceID.ToString
            Else
                strSQLQuery = strSQLQuery & "NULL"
            End If

            ' Project ID.
            strSQLQuery = strSQLQuery & ", " & m_intProjectID.ToString

            ' Checklist ID.
            strSQLQuery = strSQLQuery & ", " & m_intChecklistID.ToString

            ' RFI ID.
            strSQLQuery = strSQLQuery & ", " & m_intRFIID.ToString

            ' Invoice ID.		
            strSQLQuery = strSQLQuery & ", NULL"

            ' Get the checklist instance id.
            m_intChecklistInstanceID = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), Integer)


            If m_intChecklistInstanceID <> 0 Then

                ' STEP 2: Enter the details of each checklist item, within the checklist instance.
                m_blnDeviationFound = False
                Dim intCtr As Integer
                m_strCheckListItemIDs = MyBase.GetFormValue("txtChecklistItemID")
                m_strChecklistInstanceItemIDs = MyBase.GetFormValue("txtChecklistInstanceItemID")

                If m_strCheckListItemIDs <> "" Then
                    m_strCheckListItemID = m_strCheckListItemIDs.Split(m_charSep)
                End If

                If m_strChecklistInstanceItemIDs <> "" Then
                    m_strChecklistInstanceItemID = m_strChecklistInstanceItemIDs.Split(m_charSep)
                End If

                For intCtr = 0 To m_strChecklistInstanceItemID.Length - 1


                    m_intChecklistItemID = CType(m_strCheckListItemID(intCtr), Integer)
                    m_intChecklistInstanceItemID = CType(m_strChecklistInstanceItemID(intCtr), Integer)

                    ' Build Query to enter the checklist item details.
                    strSQLQuery = "Exec usp_Ins_tbl_PM_RFIChecklistInstance_Items "
                    If m_intChecklistInstanceItemID <> 0 Then
                        strSQLQuery = strSQLQuery & m_intChecklistInstanceItemID
                    Else
                        strSQLQuery = strSQLQuery & "NULL"
                    End If
                    strSQLQuery = strSQLQuery & ", " & m_intChecklistInstanceID & ", " & m_intProjectID & ", " & m_intChecklistID & ", " & m_intChecklistItemID

                    ' Checklist Item Response.
                    If Trim(Request.Form("chkChecklistItemResponse" & m_intChecklistItemID)) <> "" Then
                        strSQLQuery = strSQLQuery & ", 1"
                    Else
                        strSQLQuery = strSQLQuery & ", 0"

                        ' If any of the check boxes are unchecked, then it indicates, that there is a deviation.
                        m_blnDeviationFound = True

                    End If

                    ' Comments.
                    If Trim(Request.Form("txtComments" & m_intChecklistItemID)) <> "" Then
                        strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Left(Trim(Request.Form("txtComments" & m_intChecklistItemID)), 2000)) & "'"
                    Else
                        strSQLQuery = strSQLQuery & ", NULL"
                    End If

                    ' Created By (for audit trail).				
                    strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(Trim(CType(Session("strUserName"), String))) & "'"

                    ' Insert the checklist item response.
                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

                Next

                ' STEP 3: Update the RFI record. Store the checklist instance ID in the RFI record.
                strSQLQuery = "UPDATE tbl_PM_RFIs SET ChecklistInstanceID = " & m_intChecklistInstanceID & " WHERE RFIID = " & m_intRFIID
                CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                Dim strScript As String
                strScript = "<script>" + vbCrLf

                If m_intSubmitRFI = 1 Then
                    If m_strFromList = "1" Then
                        'Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                        'strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=" + CommonFunction.Constants.APP_TAG_RFI_INITIATOR.ToString + "';" + vbCrLf
                        strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?PKToken=" + m_strToken + "&FromWhere=PM&MasterTagID=" + CommonFunction.Constants.APP_TAG_RFI_INITIATOR.ToString + "';" + vbCrLf
                        strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                        If m_strResubmit = "1" Then
                            'strScript += "window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=CheckList&RFIMode=Resubmit&MasterTagID=2073&RFIID_PK=" + m_intRFIID.ToString + "&RFIID=" + m_intRFIID.ToString + """,""_self"",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");"
                            strScript += "window.open(""../General/CommonPage.aspx?PKToken=" + m_strToken + "&Mode=ADD_NEW&ChangedBy=Initiator&Comments=CheckList&RFIMode=Resubmit&MasterTagID=2073&RFIID_PK=" + m_intRFIID.ToString + "&RFIID=" + m_intRFIID.ToString + """,""_self"",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");"
                        Else
                            'strScript += "window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=CheckList&RFIMode=Submit&MasterTagID=2073&RFIID_PK=" + m_intRFIID.ToString + "&RFIID=" + m_intRFIID.ToString + """,""_self"",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");"
                            strScript += "window.open(""../General/CommonPage.aspx?PKToken=" + m_strToken + "&Mode=ADD_NEW&ChangedBy=Initiator&Comments=CheckList&RFIMode=Submit&MasterTagID=2073&RFIID_PK=" + m_intRFIID.ToString + "&RFIID=" + m_intRFIID.ToString + """,""_self"",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");"
                        End If
                        'End by MonikaI
                    Else
                        strScript += "var objtxtChecklistInstanceID=GetParentObjectReference('frmRFI_RFI','txtChecklistInstanceID');" + vbCrLf
                        strScript += "var objCustomer=GetParentObjectReference('frmRFI_RFI','cboCustomerID');" + vbCrLf
                        strScript += "var objRFIType=GetParentObjectReference('frmRFI_RFI','cboRFITypeID');" + vbCrLf
                        strScript += "var objBilling=GetParentObjectReference('frmRFI_RFI','cboBillingCurrencyID');" + vbCrLf
                        strScript += "var objParent=GetParentFormReference('frmRFI_RFI');" + vbCrLf
                        strScript += "objtxtChecklistInstanceID.value=" + m_intChecklistInstanceID.ToString + ";" + vbCrLf
                        strScript += "	objCustomer.disabled = false;" + vbCrLf
                        strScript += "objRFIType.disabled = false;" + vbCrLf
                        strScript += "objBilling.disabled = false;" + vbCrLf
                        'strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(objParent.action, ""&Action=Save&"", ""&""), ""&Action=Copy&"", ""&""), ""&RFIID=&"", ""&RFIID=<%=m_intRFIID%>&"");" + vbCrLf
                        strScript += "if(objParent.action.indexOf(""Action=Copy"")!=-1)" + vbCrLf
                        'Commented and modified by TruptiK on 8-May-2007
                        'strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(objParent.action, ""&Action=Save&"", ""&""),""Mode=New"",""Mode=Edit""), ""&Action=Copy&"", ""&""), ""RFIID="", """")+" + """&RFIID=" + m_intRFIID.ToString + """;" + vbCrLf
                        strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(replaceSubstring(objParent.action, ""&Action=Save&"", ""&""),""Mode=New"",""Mode=Edit""), ""&Action=Copy&"", ""&""),""RFIID="", """"),""PKToken="","""")+ " + """&PKToken=" + m_strtoken1 + """+" + """&RFIID=" + m_intRFIID.ToString + """;" + vbCrLf
                        'End of modification by TruptiK on 8-May-2007
                        strScript += "else" + vbCrLf
                        strScript += "objParent.action=replaceSubstring(replaceSubstring(replaceSubstring(objParent.action, ""&Action=Save&"", ""&""), ""&Action=Copy&"", ""&""), ""&RFIID=0&"", ""&RFIID=" + m_intRFIID.ToString + "&"");" + vbCrLf
                        strScript += "objParent.submit();" + vbCrLf
                        If m_strResubmit = "1" Then
                            'strScript += "window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=ReSubmit&MasterTagID=2073&RFIID_PK=" + m_intRFIID.ToString + "&RFIID=" + m_intRFIID.ToString + """,""_self"",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");"
                            strScript += "window.open(""../General/CommonPage.aspx?PKToken=" + m_strToken + "&Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=ReSubmit&MasterTagID=2073&RFIID_PK=" + m_intRFIID.ToString + "&RFIID=" + m_intRFIID.ToString + """,""_self"",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");"
                        Else
                            'strScript += "window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&RFIID_PK=" + m_intRFIID.ToString + "&RFIID=" + m_intRFIID.ToString + """,""_self"",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");"
                            strScript += "window.open(""../General/CommonPage.aspx?PKToken=" + m_strToken + "&Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&RFIID_PK=" + m_intRFIID.ToString + "&RFIID=" + m_intRFIID.ToString + """,""_self"",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");"
                        End If
                    End If
                Else
                    strScript += "window.close();" + vbCrLf
                End If
                strScript += "</script>" + vbCrLf
                Response.Write(strScript)
            End If
        End If

        PlotPage()

    End Sub

    Public Sub New()
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    '====================================================================
    ' Procedure Name        :   PlotPage
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To plot the page for CheckList
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub PlotPage()

        PlotHiddenControls()

        'Menu
        GetMenu()

        'Legend
        Dim objLegend As WebPages.Template.PageLegends
        objLegend = New WebPages.Template.PageLegends
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        objLegend.DrawPageLegends(Nothing, arrLegendImage, arrLegend)
        objLegend = Nothing

        'Caption
        WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("PAGE_CAPTION"))

        Response.Write("<br>")

        Response.Write("<div id=PageDiv Style=""OVERFLOW: Auto; WIDTH=100%;HEIGHT=100%"">")

        'Plot Grid For Checklist Items
        PlotGridForItems()

        Response.Write("</div>")

        'Menu
        GetMenu()

    End Sub

    '====================================================================
    ' Procedure Name        :   PlotHiddenControls
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   Plot the Hidden Controls Required for the page
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub PlotHiddenControls()
        Dim strHTML As String
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML = CommonFunctions.HTMLControls.DrawTextBox("txtUseFormContents", "txtUseFormContents", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtRFIID", "txtRFIID", , , , m_intRFIID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , m_intProjectID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtChecklistID", "txtChecklistID", , , , m_intChecklistID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtChecklistInstanceID", "txtChecklistInstanceID", , , , m_intChecklistInstanceID.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtSubmitRFI", "txtSubmitRFI", , , , m_intSubmitRFI.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtFromList", "txtFromList", , , , m_strFromList, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtResubmit", "txtResubmit", , , , m_strResubmit, , , , , , True, , True, EnableHTMLEncode:=True)
        'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
        strHTML += CommonFunctions.HTMLControls.DrawTextBox("txtHiddenToken", "txtHiddenToken", , , , m_strToken, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        'End of addition by MonikaI
        Response.Write(strHTML)
    End Sub

    '====================================================================
    ' Procedure Name        :   GetMenu
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   Plot the Menu for Page
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'Display the static menu
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), _
                                  MyBase.GetResourceString("MENU_CLOSE"), _
                                  MyBase.GetResourceString("MENU_HELP")}

        'Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
        'Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('INV_GEN_FILL_CHECKLIST')"}
        Dim arrClientSideFunctions() As String = {"Save_OnClick('" + m_strToken + "'," + CType(m_intRFIID, String) + ")", "Close_OnClick()", "Help_OnClick('INV_GEN_FILL_CHECKLIST')"}
        'End by MonikaI

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HELP_TOOLTIP")}


        Dim objMenu As New WebPages.Template.StaticMenu
        Dim strMenu As String = objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        objMenu = Nothing

        Response.Write(strMenu)

        MyBase.InitializeResources("AppResources.RFI_RFICheckList", "AppResources")

    End Sub

    '====================================================================
    ' Procedure Name        :   PlotGridForItems
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To Plot the grid for Checklist
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   July 30, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub PlotGridForItems()
        Dim strGrid As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        Dim strSQL As String = "Exec usp_Sel_tbl_PM_RFIChecklist_Items_ForInvoiceGeneration " & m_intChecklistID.ToString
        If m_intChecklistInstanceID <> 0 Then
            strSQL = strSQL & ", " & m_intChecklistInstanceID.ToString
        End If

        m_objGrid = New WebPages.Template.AdvancedGrid
        Dim arrActualColumnArray() As String = {"", "RFIChecklistItem", "", ""}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("SR_NO"), _
                                              MyBase.GetResourceString("CHKITEM"), _
                                                MyBase.GetResourceString("YES"), _
                                                MyBase.GetResourceString("COMMENTS")}

        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGrid.DIVID = "divCheckList"
        m_objGrid.DIVStyle = "'overflow:auto;width:100%;height=0'"

        m_objGrid.UseSQL = MyBase.UseSQL
        m_objGrid.SQL = strSQL
        m_objGrid.PrimaryKey = "RFIChecklistItemID"
        m_objGrid.NoOfDataColumns = 1
        m_objGrid.returnHTML = True
        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        m_objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        strGrid = m_objGrid.DrawGrid()
        m_objGrid = Nothing
        Response.Write(strGrid)
    End Sub

#End Region

#Region "Grid Events"

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        m_intCounter = m_intCounter + 1

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim intChecklistItemID As Integer
        Dim intChecklistInstanceItemID As Integer
        intChecklistItemID = CType(CommonFunction.General.CheckIsNothing(Args.DataReader.Item("RFIChecklistItemID")), Integer)
        intChecklistInstanceItemID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RFIChecklistInstanceItemID"), "0"), Integer)
        Select Case Args.ColIndex
            Case 0
                Cancel = True
                Args.StringToBeInserted = "<td  valign=top align=right>" + m_intCounter.ToString + "</td>"
            Case 1
                Cancel = True
                ''Commented and Added By Vidya J ON 1 Sep 2016 For MasterCard NextGen Upgrade
                'Args.StringToBeInserted = _
                '"<td  valign=top>" + CType(CommonFunction.General.CheckIsNothing(Args.DataReader.Item("RFIChecklistItem")), String) + _
                '"<input type=hidden id=txtChecklistItemID name=txtChecklistItemID value=" + intChecklistItemID.ToString + ">" + vbCrLf + _
                ' "<input type=hidden id=txtChecklistInstanceItemID name=txtChecklistInstanceItemID value=" + intChecklistInstanceItemID.ToString + ">" + _
                ' "</td>"

                Args.StringToBeInserted = _
                "<td  valign=top>" + CType(CommonFunction.General.CheckIsNothing(HttpUtility.HtmlEncode(Args.DataReader.Item("RFIChecklistItem"))), String) + _
                "<input type=hidden id=txtChecklistItemID name=txtChecklistItemID value=" + intChecklistItemID.ToString + ">" + vbCrLf + _
                 "<input type=hidden id=txtChecklistInstanceItemID name=txtChecklistInstanceItemID value=" + intChecklistInstanceItemID.ToString + ">" + _
                 "</td>"
                ''End Of Commented and Added By Vidya J ON 1 Sep 2016 For MasterCard NextGen Upgrade
            Case 2
                Cancel = True

                Dim strToBeInserted As String
                If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFIChecklistItemResponse"), "false"), Boolean) = True Then
                    strToBeInserted = "checked"
                End If
                'Added and commented by PrashantSJ on 02 May 2007
                'Purpose: This code will also work in Mozilla 
                'Args.StringToBeInserted = "<td valign=top>" + _
                '                "<input type=checkbox id=chkChecklistItemResponse  name=chkChecklistItemResponse" + intChecklistItemID.ToString + _
                '                    " value = " + intChecklistItemID.ToString + " " + strToBeInserted + " ></td>"
                Args.StringToBeInserted = "<td valign=top>" + _
                               "<input type=checkbox id=chkChecklistItemResponse" + m_intCounter.ToString + "  name=chkChecklistItemResponse" + intChecklistItemID.ToString + _
                                   " value = " + intChecklistItemID.ToString + " " + strToBeInserted + " ></td>"
                'End of addition by PrashantSJ on 02 May 2007 
            Case 3
                Cancel = True
                'Modified By ShraddhaM on 27 July 2006
                'Commented and modified by MonikaI on 21-Sep-2006
                'Added and commented by PrashantSJ on 02 May 2007
                'Purpose: This code will also work in Mozilla                 'Args.StringToBeInserted = "<td  valign=top>" + _
                '                          CommonFunctions.HTMLControls.DrawTextArea("txtComments" + intChecklistItemID.ToString, "txtComments", , , , , , , 200, 60, 2000, CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("Comments")), String), , , , , , , , True, , , , , , , "Soft", ) + _
                '                        "</td>"
                Args.StringToBeInserted = "<td  valign=top>" + _
                                          CommonFunctions.HTMLControls.DrawTextArea("txtComments" + intChecklistItemID.ToString, "txtComments" + intChecklistItemID.ToString, , , , , , , 200, 60, 2000, CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("Comments")), String), , , , , , , , True, , , , , , , "Soft", EnableHTMLEncode:=True) + _
                                        "</td>"
                'CommonFunctions.HTMLControls.DrawTextArea("txtComments" + intChecklistItemID.ToString, "txtComments", , , , , , , 200, 60, 2000, CType(CommonFunction.General.CheckIsNothing(Args.DataReader.Item("Comments")), String), , , , , , , , True, , , , , , , "Soft", ) + _
                'End by MonikaI
                'End of addition by PrashantSJ on 02 May 2007
        End Select

    End Sub


#End Region


    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
        'Added by TruptiK on 9-May-2007
        m_strtoken1 = CommonFunctions.Security.Token.GetToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
        'End of addition by TruptiK on 9-May-2007
        m_strToken = ""
        If HttpContext.Current.Request.QueryString("PKToken") Is Nothing Then
            m_strToken = Request.Form("txtHiddenToken") & ""
        Else
            m_strToken = Request.QueryString("PKToken") & ""
        End If

        If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String) + "Submitted", m_strToken) = False Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub
End Class
