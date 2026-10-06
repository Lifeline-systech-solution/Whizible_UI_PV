Partial Public Class DB_CustomerPortal
    Inherits WebPages.Template.WhizTemplate
    Protected strHTML As New System.Text.StringBuilder
    Private WithEvents objMilestoneGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objProductGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objAMCGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objDeliverableGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objTaskGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objProjectGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objInvoiceGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objMilestoneTaskGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objUpcomingInvoicesGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objSOAGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objOpenRequest As New WebPage.Templates.GenericGrid
    Private WithEvents objResolvedRequest As New WebPage.Templates.GenericGrid
    Private WithEvents objCustomerGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objCustomerGridDetails As New WebPage.Templates.GenericGrid
    Private WithEvents objThreadGrid As New WebPage.Templates.GenericGrid
    Protected CustomerID As String
    Protected mode1 As String
    Private mode As String
    Private m_CustomerName As String = ""
    Private m_ProjectName As String = ""
    Private m_PostID As String = ""
    Private m_UserID As String = ""
    Private mode2 As String = ""
    Private m_GroupTotal As Double = 0
    Private m_intGroupNumber As Integer = -1
    Private details As String
    Protected Opreation As String
    Protected m_GroupTotal1 As Double = 0
    Protected m_GroupTotal2 As Double = 0
    Protected m_intGroupNumber1 As Integer = -1
    Protected m_dtGreaterthanDate As String
    Protected m_dtLessthanDate As String
    Protected m_PKToken_Query_DT As String
    Protected m_lngEmployeeID As String
    Protected QueryID As String
    Protected m_Action As Integer
    Protected m_Flag As String
    Protected flag As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

    End Sub
    Protected Sub WritePage()
        Call InitVariables()
        Call PlotHiddenControls()
        Select Case mode.ToUpper
            Case "MENU"
                Call DrawMenuTable()
                Return
            Case "HEADER"
                Call DrawHeader()
                Return
            Case "MAIN"
                Call DrawCaption()

                Select Case m_Action
                    Case 0
                        Call DisplayProjectTabs()
                        Call DisplayProjectGrid()
                    Case 1
                        Call DisplayProjectTabs()
                        Call DisplayProjectGrid()
                    Case 2
                        'Call DrawCaption()
                        Call DisplaySOAGrid()
                    Case 3
                        DisplayUpcomingInvoiceGrid()
                    Case 4
                        Call Draw()
                        DisplayInvoiceGrid()
                    Case 7
                        DisplayCustomerGridDetails()
                    Case 6
                        CommonFunction.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                        CommonFunction.General.WriteHTML("window.open('../IB/IB_IssueStatusBasedReport.aspx?CustomerID=" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "") + "&Mode=Dashboard','_self');")
                        CommonFunction.General.WriteHTML("</script>")
                    Case 8
                        CommonFunction.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                        CommonFunction.General.WriteHTML("window.open('../DB/DB_CustomerFieldLock.aspx?CustomerID=" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "") + "&Mode=Dashboard','_self');")
                        CommonFunction.General.WriteHTML("</script>")
                    Case 5
                        CommonFunction.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                        CommonFunction.General.WriteHTML("window.open('../IB/IB_IssueStatusBasedReport.aspx?CustomerID=" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "") + "&Detail=Issue&Mode=Dashboard','_self');")
                        CommonFunction.General.WriteHTML("</script>")
                End Select
                Return
        End Select
    End Sub
    Private Function GenerateMenu() As String
        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        If details <> "" Then
            ArrTopMenuCaptionsList.Add("Close")
            ArrTopMenuToolTipsList.Add("Close")
            ArrTopMenuFunctionsList.Add("Close_Click()")

            Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
            ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
            ArrTopMenuCaptionsList = Nothing

            Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
            ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
            ArrTopMenuToolTipsList = Nothing

            Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
            ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
            ArrTopMenuFunctionsList = Nothing

            'Generate menu string and return
            Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
        End If
    End Function
    Private Sub PlotHiddenControls()
        If Not HttpContext.Current.Request.QueryString("Grid") Is Nothing AndAlso HttpContext.Current.Request.QueryString("Grid") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Grid1 value=" + HttpContext.Current.Request.QueryString("Grid") + ">")
        ElseIf Not HttpContext.Current.Request.Form("Grid1") Is Nothing AndAlso HttpContext.Current.Request.Form("Grid1") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Grid1 value=" + HttpContext.Current.Request.Form("Grid1") + ">")
        End If

        If Not HttpContext.Current.Request.QueryString("Mode") Is Nothing AndAlso HttpContext.Current.Request.QueryString("Mode") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Mode value=" + HttpContext.Current.Request.QueryString("Mode") + ">")
        ElseIf Not HttpContext.Current.Request.Form("Mode") Is Nothing AndAlso HttpContext.Current.Request.Form("Mode") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Mode value=" + HttpContext.Current.Request.Form("Mode") + ">")
        End If

        If Not HttpContext.Current.Request.QueryString("Opreation") Is Nothing AndAlso HttpContext.Current.Request.QueryString("Opreation") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Opreation value=" + HttpContext.Current.Request.QueryString("Opreation") + ">")
        ElseIf Not HttpContext.Current.Request.Form("Opreation") Is Nothing AndAlso HttpContext.Current.Request.Form("Opreation") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Opreation value=" + HttpContext.Current.Request.Form("Opreation") + ">")
        End If
        If Not HttpContext.Current.Request.QueryString("Action") Is Nothing AndAlso HttpContext.Current.Request.QueryString("Action") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Action value=" + HttpContext.Current.Request.QueryString("Action") + ">")
        ElseIf Not HttpContext.Current.Request.Form("Action") Is Nothing AndAlso HttpContext.Current.Request.Form("Action") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Action value=" + HttpContext.Current.Request.Form("Action") + ">")
        End If

        If Not HttpContext.Current.Request.QueryString("Flag") Is Nothing AndAlso HttpContext.Current.Request.QueryString("Flag") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Flag value=" + HttpContext.Current.Request.QueryString("Flag") + ">")
        ElseIf Not HttpContext.Current.Request.Form("Flag") Is Nothing AndAlso HttpContext.Current.Request.Form("Flag") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=Flag value=" + HttpContext.Current.Request.Form("Flag") + ">")
        End If
    End Sub
    Private Sub InitVariables()

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        If HttpContext.Current.Request.QueryString("CustomerID") <> "" Then
            HttpContext.Current.Session("int_customerPortal_CustomerID") = HttpContext.Current.Request.QueryString("CustomerID")
        End If

        If HttpContext.Current.Request.QueryString("Action") <> "" Then
            HttpContext.Current.Session("int_customerPortal_ActionID") = HttpContext.Current.Request.QueryString("Action")
        End If
        If Request.QueryString("Mode") Is Nothing Then
            mode = Request.Form("Mode")
        Else
            mode = Request.QueryString("Mode")
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")) <> "" Then
            m_Action = Request.QueryString("Action")
        ElseIf HttpContext.Current.Session("int_customerPortal_ActionID") <> "" Then
            'If CommonFunctions.General.CheckIsNothing(Request.Form("Action")) <> "" Then
            'm_Action = Request.QueryString("Action")
            'Else
            m_Action = HttpContext.Current.Session("int_customerPortal_ActionID")
        Else
            m_Action = 0
            'End If
        End If

        If HttpContext.Current.Request.QueryString("Grid") Is Nothing And HttpContext.Current.Request.QueryString("Mode") = "Milestone" Or mode = "Milestone" Then
            mode2 = "Planned"
        Else
            mode2 = ""
        End If
        If Request.QueryString("Grid") Is Nothing Then
            mode1 = Request.Form("Grid1")
        Else
            mode1 = Request.QueryString("Grid")
        End If
        If Request.QueryString("Opreation") Is Nothing Then
            Opreation = Request.Form("Opreation")
        Else
            Opreation = Request.QueryString("Opreation")
        End If

        If Request.QueryString("Flag") Is Nothing Then
            m_Flag = Request.Form("Flag")
        Else
            m_Flag = Request.QueryString("Flag")
        End If
        m_UserID = HttpContext.Current.Session("intUserID").ToString
        m_PostID = HttpContext.Current.Session("intPostID").ToString

        'If HttpContext.Current.Request.QueryString("Grid") Is Nothing Then
        '    mode1 = Request.Form("Grid1")
        'Else
        '    mode1 = Request.QueryString("Grid")
        'End If

        If Not HttpContext.Current.Request.QueryString("Details") Is Nothing AndAlso HttpContext.Current.Request.QueryString("Details") <> "" Then
            details = Request.QueryString("Details")
        End If

    End Sub
    Private Sub DrawMenuTable()
        CommonFunction.General.WriteHTML("<script language='javascript'>" + vbCrLf)
        'CommonFunction.General.WriteHTML("function td_OnClick(intTdId)")
        'CommonFunction.General.WriteHTML("{")
        'CommonFunction.General.WriteHTML("alert(intTdId);")
        'CommonFunction.General.WriteHTML("if (intTdId==1){")
        'CommonFunction.General.WriteHTML("parent.document.getElementsByTagName(frame)[4].src='../DB/DB_CustomerPortal.aspx?Opreation=DetailInfo'");
        'CommonFunction.General.WriteHTML("}}")
        CommonFunction.General.WriteHTML("function td_OnMouseover(obj)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("obj.style.cursor='hand';")
        CommonFunction.General.WriteHTML("obj.style.bgcolor ='RED';")
        CommonFunction.General.WriteHTML("}" + vbCrLf)
        CommonFunction.General.WriteHTML("</script>" + vbCrLf)
        CommonFunction.General.WriteHTML("<table id='tbl_menu' name='tbl_menu' width='100%' height='100%' bgcolor='LightBlue'>")
        CommonFunction.General.WriteHTML("<tr id='tr1' name='tr1' class='clsTREven' valign='middle'>")
        CommonFunction.General.WriteHTML("<td id='td1' name='td1' onmouseover='td_OnMouseover(this)'  align='center' onclick='td_OnClick(1)'>Projects</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr id='tr2' name='tr2' class='clsTREven' valign='middle'>")
        CommonFunction.General.WriteHTML("<td id='td2' name='td2' onmouseover='td_OnMouseover(this)'  align='center' onclick='td_OnClick(2)'>SOA</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr id='tr3' name='tr3' class='clsTREven' valign='middle'>")
        CommonFunction.General.WriteHTML("<td id='td3' name='td3' onmouseover='td_OnMouseover(this)' align='center' onclick='td_OnClick(3)'>Upcoming Invoices</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr id='tr4' name='tr4' class='clsTREven' valign='middle'>")
        CommonFunction.General.WriteHTML("<td id='td4' name='td4' onmouseover='td_OnMouseover(this)' align='center' onclick='td_OnClick(4)'>Invoices not Paid</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr id='tr5' name='tr5' class='clsTREven' valign='middle'>")
        CommonFunction.General.WriteHTML("<td id='td5' name='td5' onmouseover='td_OnMouseover(this)' align='center' onclick='td_OnClick(5)'>Issues</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr id='tr6' name='tr6' class='clsTREven' valign='middle'>")
        CommonFunction.General.WriteHTML("<td id='td6' name='td6' onmouseover='td_OnMouseover(this)' align='center' onclick='td_OnClick(6)'>Help Desk</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr id='tr7' name='tr7' class='clsTREven' valign='middle'>")
        CommonFunction.General.WriteHTML("<td id='td7' name='td7' onmouseover='td_OnMouseover(this)' align='center' onclick='td_OnClick(7)'>Customer Details</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr id='tr8' name='tr8' class='clsTREven' valign='middle'>")
        CommonFunction.General.WriteHTML("<td id='td8' name='td8' onmouseover='td_OnMouseover(this)' align='center' onclick='td_OnClick(8)'>Field Logs</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")

    End Sub
    Private Sub DrawHeader()
        Dim StrUserName As String
        Dim strQuery As String = ""
        Dim AlertLevel As String = ""
        Dim Supporttype As String = ""
        Dim customerid As String
        Dim CategoryID As String
        If Not (Request.Form("cboCategory")) Is Nothing Then
            CategoryID = CommonFunction.General.CheckIsNothing(Request.Form("cboCategory"), "NULL")
        End If
        If CategoryID = "" Then
            CategoryID = "NULL"
        End If
        customerid = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "")
        Dim drGrid As IDataReader

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT CustomerName FROM TBL_PM_Customer WHERE Customer= " & m_UserID
        strQuery = "usp_sel_tbl_PM_Customer_CustomerName '" & m_UserID.ToString() & "'"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        StrUserName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
        If m_PostID <> 23 Then
            If Not (Request.Form("cboCustomer")) Is Nothing Then
                customerid = CommonFunction.General.CheckIsNothing(Request.Form("cboCustomer"), "NULL")
            End If
            If customerid = "" Then
                customerid = "NULL"
            End If
        End If
        If m_PostID = 23 Then
            customerid = m_UserID
        End If

        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='100%' class=clsTable>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD align=Left>Customer" + vbCrLf)
        CommonFunction.General.WriteHTML("&nbsp;" + vbCrLf)
        If m_PostID <> 23 Then
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboCustomer", "usp_sel_Customer", 250, customerid, "onChange=comboChanged()", True, True))
            CommonFunction.General.WriteHTML("&nbsp;" + vbCrLf)
            CommonFunction.General.WriteHTML("<A Href='javascript:Customer_OnClick()' Title='Select Customer'><IMG src='../../Images/Lookup.gif' id='ResourceSelection' border=0></A>")
        Else
            CommonFunction.General.WriteHTML(" : " + StrUserName)
        End If


        If customerid <> "NULL" Then
            strQuery = " Exec usp_sel_customer_Details " & customerid
            drGrid = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
            While drGrid.Read()
                AlertLevel = CommonFunction.Data.CheckIsDBNull(drGrid("color").ToString(), "")
                Supporttype = CommonFunction.Data.CheckIsDBNull(drGrid("Category").ToString(), "")
            End While
            CommonFunction.Data.DisposeDataReader(drGrid)

            CommonFunction.General.WriteHTML("&nbsp;" + vbCrLf)
            'CommonFunction.General.WriteHTML("<TD align=Left>Support Type" + vbCrLf)
            CommonFunction.General.WriteHTML("&nbsp;" + vbCrLf)
            CommonFunction.General.WriteHTML("Support Type : " + Supporttype)
            'CommonFunction.General.WriteHTML(" : " + Supporttype)
            'CommonFunction.General.WriteHTML("</TD>" + vbCrLf)
            'CommonFunction.General.WriteHTML("<TD align=Left>Alert Level</td>" + vbCrLf)
            CommonFunction.General.WriteHTML("&nbsp;" + vbCrLf)
            CommonFunction.General.WriteHTML("Alert Level : ")
            CommonFunction.General.WriteHTML("</TD>" + vbCrLf)
            CommonFunction.General.WriteHTML("<td bgcolor=" & AlertLevel.ToString & " width=40 height=12 ></td>")
        End If
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TABLE>" + vbCrLf)
        CommonFunction.General.WriteHTML("<BR>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='100%' class=clsTable>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD align=Left>Show Me All Customer With" + vbCrLf)
        CommonFunction.General.WriteHTML("&nbsp;" + vbCrLf)
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboCategory", "USP_SEL_CATEGORTY", 150, CategoryID, "onChange=comboChanged1()", True, True))
        CommonFunction.General.WriteHTML("Support Type" + vbCrLf)

        CommonFunction.General.WriteHTML("</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TABLE>" + vbCrLf)
    End Sub
    Private Sub Draw()

        m_dtGreaterthanDate = CommonFunction.General.CheckIsNothing(Request.Form("txtgreaterthanDate"), "")
        m_dtLessthanDate = CommonFunction.General.CheckIsNothing(Request.Form("txtLessthanDate"), "")

        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD align=Left>Due Date >=" + vbCrLf)
        CommonFunction.General.WriteHTML("&nbsp;")
        'strHTML.Append("</TD>" + vbCrLf)
        'strHTML.Append("<TD>" + vbCrLf)
        'strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtgreaterthanDate", "txtgreaterthanDate", , 80, m_dtGreaterthanDate, "frmCustomerPortal", returnHTML:=True, IsMandatory:=False))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("txtgreaterthanDate", "txtgreaterthanDate", , , m_dtGreaterthanDate, , "frmCustomerPortal", , , , , , , True, , , "onkeypress=""javascript:setDateFilter(event)"""))
        CommonFunction.General.WriteHTML("</TD>" + vbCrLf)

        'strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>" + vbCrLf)
        'strHTML.Append("<TR class=clsTRPageCaption>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD align=Left>Due Date <=" + vbCrLf)
        CommonFunction.General.WriteHTML("&nbsp;")
        'strHTML.Append("</TD>" + vbCrLf)
        'strHTML.Append("<TD>" + vbCrLf)
        'strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtLessthanDate", "txtLessthanDate", , 80, m_dtLessthanDate, "frmCustomerPortal", returnHTML:=True, IsMandatory:=False))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("txtLessthanDate", "txtLessthanDate", , , m_dtLessthanDate, , "frmCustomerPortal", , , , , , , True, , , "onkeypress=""javascript:setDateFilter(event)"""))
        CommonFunction.General.WriteHTML("</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("&nbsp;&nbsp;<a class='clsSelected'  Title='Show' href='javascript:Show_OnClick(""Show"")'>Show</a>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TABLE>" + vbCrLf)
        CommonFunction.General.WriteHTML("<BR>" + vbCrLf)

    End Sub
    Private Sub DrawCaption()
        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>" + vbCrLf)
        If m_Action = 2 Then
            CommonFunction.General.WriteHTML("<TD align=center><font size=2px>SOA</font>" + vbCrLf)
        ElseIf m_Action = 3 Then
            CommonFunction.General.WriteHTML("<TD align=center><font size=2px>Upcoming Invoices</font>" + vbCrLf)
        ElseIf m_Action = 4 Then
            CommonFunction.General.WriteHTML("<TD align=center><font size=2px>Invoices Not Paid</font>" + vbCrLf)
        ElseIf m_Action = 5 Then
            CommonFunction.General.WriteHTML("<TD align=center><font size=2px>Issues</font>" + vbCrLf)
            'ElseIf m_Action = 6 Then
            'CommonFunction.General.WriteHTML("<TD align=center><font size=2px>Help Desk</font>" + vbCrLf)
        ElseIf m_Action = 7 Then
            CommonFunction.General.WriteHTML("<TD align=center><font size=2px>Customer Details</font>" + vbCrLf)
        End If
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TABLE>" + vbCrLf)
        CommonFunction.General.WriteHTML("<BR>" + vbCrLf)
    End Sub
    Private Sub DrawOtherInfo()
        Dim StrUserName As String
        Dim strQuery As String = ""
        strQuery = "SELECT CustomerName FROM TBL_PM_Customer WHERE Customer= " & m_UserID
        StrUserName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
        If m_PostID <> 23 Then
            If Not (Request.Form("cboCustomer")) Is Nothing Then
                CustomerID = CommonFunction.General.CheckIsNothing(Request.Form("cboCustomer"), "NULL")
            End If
            If CustomerID = "" Then
                CustomerID = "NULL"
            End If
        End If
        If m_PostID = 23 Then
            CustomerID = m_UserID
        End If

        strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='100%' class=clsTable>" + vbCrLf)
        strHTML.Append("<TR class=clsTRPageCaption>" + vbCrLf)
        strHTML.Append("<TD align=Left>Customer" + vbCrLf)
        strHTML.Append("&nbsp;" + vbCrLf)
        If m_PostID <> 23 Then
            strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboCustomer", "usp_sel_Customer", 250, CustomerID, "onChange=comboChanged()", True, True))
            strHTML.Append("&nbsp;" + vbCrLf)
            'strHTML.Append("<A Href=""javascript:Customer_OnClick() Title='Select Reporting To'><IMG src='../../Images/Lookup.gif' id='ResourceSelection' border=0""></A>")
            strHTML.Append("<A Href='javascript:Customer_OnClick()' Title='Select Customer'><IMG src='../../Images/Lookup.gif' id='ResourceSelection' border=0></A>")
        Else
            strHTML.Append(" : " + StrUserName)
        End If
        strHTML.Append("<TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)
        strHTML.Append("</TABLE>" + vbCrLf)
        strHTML.Append("<BR>" + vbCrLf)
        'strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='100%' class=clsTable>" + vbCrLf)
        'strHTML.Append("<TR class=clsTRPageCaption>" + vbCrLf)
        'strHTML.Append("<TD align=left Title='Customer Name'>" + vbCrLf)
        'strHTML.Append("<A href=""javascript:Customer_OnClick()"">")
        'strHTML.Append("Select Customer </A></TD>")
        'strHTML.Append("&nbsp;" + vbCrLf)
        'strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboCustomer", "usp_sel_Customer", 250, , "onChange=comboChanged()", True, True))
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomer", "txtCustomer", , 200, 100, , , , , True, , , , True, True, , , , 10))

    End Sub
    Private Sub DisplayCustomerGridDetails()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================

        Dim ArrActualFieldNames() As String = {"CustomerName", "Address", "City", "Phone", "MobileNumber", "EmailID"}
        Dim ArrUserFriendlyFieldNames() As String = {"Customer Name", "Address", "City", "Phone", "MobileNumber", "EmailID"}
        'Dim ArrTDStyle() As String = {"align=left width=20%", "align=centre width=20%", "align=left width=20%", "align=left width=20%", "align=left width=20%"}
        'Dim arrRowLink() As String = {"Name_OnClick()", "", "", "", "", ""}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = " Exec usp_sel_CustomerInfo " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "")
        With objCustomerGridDetails
            .ActualColumnArray = ArrActualFieldNames
            '.GroupOnColumn = ArrGroupOnColumn
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            '.TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 6
            .DIVID = "divList"
            .DIVHeight = 500
            .DIVStyle = "overflow:auto;width:100%;"
            '.RowLinkArray = arrRowLink
            '.PrimaryKey = "CustomerProductVersionID"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    Private Sub DisplayCustomerGrid()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================

        Dim ArrActualFieldNames() As String = {"CustomerName", "Category", "color"}
        Dim ArrUserFriendlyFieldNames() As String = {"Customer Name", "Support Type", "Alert Level"}
        'Dim ArrTDStyle() As String = {"align=left width=20%", "align=centre width=20%", "align=left width=20%", "align=left width=20%", "align=left width=20%"}
        'Dim arrRowLink() As String = {"Name_OnClick()", "", "", "", "", ""}
        If CustomerID = "" Then
            CustomerID = "NULL"
        End If
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = " Exec usp_sel_customer_Details " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "")
        With objCustomerGrid
            .ActualColumnArray = ArrActualFieldNames
            '.GroupOnColumn = ArrGroupOnColumn
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            '.TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 3
            .DIVID = "divList"
            .DIVHeight = 500
            .DIVStyle = "overflow:auto;width:100%;"
            '.RowLinkArray = arrRowLink
            '.PrimaryKey = "CustomerProductVersionID"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub

    Private Sub objCustomerGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objCustomerGrid.DataRowTD_BeforePrint
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strDrawTable As String

        ' replace the TD with TD having palette color sequence 
        If UCase(Trim(Args.DataField & "")) = "COLOR" Then
            Cancel = True
            Args.EnableLink = False
            strSQL = "usp_sel_AlertLevel " + CommonFunctions.Data.CheckIsDBNull((Args.DataReader("AlertID")), "0").ToString
            dr = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            strDrawTable = "<TD><table cellpadding=""1"" cellspacing=""1"" bordercolor=""BLACK"" bgColor=""black"" ><tr>"
            Do While dr.Read()
                strDrawTable += "<td bgcolor=" & dr.Item("Color").ToString & " width=40 height=12 ></td>"
            Loop
            CommonFunctions.Data.DisposeDataReader(dr)
            strDrawTable += "</tr></table></TD>"

            Args.StringToBeInserted = strDrawTable
        End If

    End Sub
    Private Sub DisplayProjectTabs()
        CommonFunction.General.WriteHTML("<table border=0 width=100% cellspacing=0 cellpadding=0 class='clsTableNavLinks'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<table border=0 width=100% cellspacing=0 cellpadding=0 class='clsTableNavLinks'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTRNavLinks valign=middle>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD>" + vbCrLf)
        If mode1 = "InProgressProject" Or mode1 = "" Then
            CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='In Progress' href='javascript:ItemTab_OnClick(""In ProgressProject"")' >In Progress</a>" + vbCrLf)
        Else
            CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='In Progress' href='javascript:ItemTab_OnClick(""In ProgressProject"")' >In Progress</a>" + vbCrLf)
        End If
        If mode1 = "ClosedProjects" Then
            CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='In Progress' href='javascript:ItemTab_OnClick(""ClosedProjects"")' >Closed</a>" + vbCrLf)
        Else
            CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='In Progress' href='javascript:ItemTab_OnClick(""ClosedProjects"")' >Closed</a>" + vbCrLf)
        End If

        CommonFunction.General.WriteHTML("</TD> </TR> </TABLE><br>" + vbCrLf)
    End Sub
    Private Sub DisplayProjectGrid()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================

        Dim ArrActualFieldNames() As String = {"ProjectName", "ProjectManager", "ExpectedStartDate", "ExpectedEndDate", "ShowReport", "Utilization"}
        Dim ArrUserFriendlyFieldNames() As String = {"Project Name", "ProjectManager", "Start Date", "End Date", "Show Report", "Resource Utilization"}
        Dim ArrTDStyle() As String = {"align=centre width=20%", "align=centre width=20%", "align=left width=20%", "align=left width=20%", "align=left width=10%", "align=left width=10%"}
        Dim arrRowLink() As String = {"", "", "", "", "ViewReport(ProjectID)", "ResourceUtilization(ProjectID)"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        If mode1 = "" Then
            mode1 = "InProgressProject"
        End If
        strSQL = " Exec usp_sel_Projects_Customer " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "") & "," & mode1
        With objProjectGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 5
            .DIVID = "divList"
            .DIVHeight = 600
            .DIVStyle = "overflow:auto;width:100%;"
            .RowLinkArray = arrRowLink
            .PrimaryKey = "ProjectID"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    Private Sub DisplaySOAGrid()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================

        Dim ArrActualFieldNames() As String = {"TransactionDate", "Particulars", "NatureOfInvoice", "InvoiceNumber", "InvoiceAmount", "ReceiptAmount", "OutstandingAmount", "OutstandingDays"}
        Dim ArrUserFriendlyFieldNames() As String = {"Transaction Date", "Particulars", "Nature Of Invoice", "Invoice Number", "Amount", "Receipt Amount", "Outstanding Amount", "Outstanding Days"}
        Dim ArrTDStyle() As String = {"align=centre width=10%", "align=left width=5%", "align=left width=10%", "align=LEFT width=15%", "align=right width=10%", "align=right width=15%", "align=right width=15%", "align=right width=15%"}
        Dim ArrSummaryFunctions() As String = {"", "", "", "", "SUM", "SUM", "SUM"}
        Dim ArrGroupSummaryFunctions() As String = {"", "", "", "", "SUM", "SUM", "SUM"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        strSQL = " Exec usp_Rpt_SOA_Customer " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "")
        With objSOAGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 8
            .DIVID = "divList"
            .DIVHeight = 600
            .DIVStyle = "overflow:auto;width:100%;"
            '.PrimaryKey = "IRID"
            '.RowLinkArray = arrRowLink
            '.GroupSummaryFunc = ArrGroupSummaryFunctions
            .GroupSummaryFunc = ArrGroupSummaryFunctions
            .SummaryFunctions = ArrSummaryFunctions
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    Private Sub DisplayUpcomingInvoiceGrid()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================
        Opreation = "Pending"
        Dim ArrActualFieldNames() As String = {"ProjectName", "InvoiceNumber", "InvoiceDate", "BaseAmount", "Amount", "ProjectAmount"}
        Dim ArrUserFriendlyFieldNames() As String = {"Project Name", "IR ID", "Raised On", "Billing Currency amount", "Base Currency Amount", "Project currency amount"}
        Dim ArrTDStyle() As String = {"align=centre width=15%", "align=left width=15%", "align=left width=10%", "align=right width=10%", "align=right width=15%", "align=right width=10%"}
        'Dim ArrGroupSummaryFunctions() As String = {"", "", "", "", "", "", "SUM"}
        'Dim arrRowLink() As String = {"", "", "ShowDetailsofRFI(IRID)", "", "", "", ""}
        Dim strSQL As String
        strSQL = " Exec usp_sel_Invoice_Customer " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "") & "," & "Pending"
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        With objUpcomingInvoicesGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 6
            .DIVID = "divList"
            .DIVHeight = 600
            .DIVStyle = "overflow:auto;width:100%;"
            .PrimaryKey = "IRID"
            '.RowLinkArray = arrRowLink
            '.GroupSummaryFunc = ArrGroupSummaryFunctions
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    Private Sub DisplayInvoiceGrid()
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : TruptiK
        ' Created               : 16-July-2008
        ' Revisions             :
        '=====================================================================
        Opreation = "InvoicesNotPaid"
        If m_dtGreaterthanDate = "" Then
            m_dtGreaterthanDate = "NULL"
        Else
            m_dtGreaterthanDate = "'" + m_dtGreaterthanDate + "'"
        End If
        If m_dtLessthanDate = "" Then
            m_dtLessthanDate = "NULL"
        Else
            m_dtLessthanDate = "'" + m_dtLessthanDate + "'"
        End If
        Dim ArrActualFieldNames() As String = {"ProjectName", "InvoiceNumber", "InvoiceDate", "DueDate", "BaseAmount", "Amount", "ProjectAmount", "InvPaymentBillingCurrencyAmount", "BalanceAmount"}
        Dim ArrUserFriendlyFieldNames() As String = {"Project Name", "Invoice NO", "Invoice Date", "Due Date", "Billing Currency amount", "Base Currency Amount", "Project currency amount", "Receipt Amount", "Balance Amount"}
        Dim ArrTDStyle() As String = {"align=centre width=10%", "align=left width=15%", "align=left width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%"}
        'Dim ArrGroupSummaryFunctions() As String = {"", "", "", "", "", "", "SUM"}
        'Dim arrRowLink() As String = {"", "", "ShowDetailsofRFI(IRID)", "", "", "", ""}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = " Exec usp_sel_Invoice_Customer " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("int_customerPortal_CustomerID"), "") & "," & Opreation & "," & m_dtGreaterthanDate & "," & m_dtLessthanDate
        With objInvoiceGrid
            .ActualColumnArray = ArrActualFieldNames
            '.GroupOnColumn = ArrGroupOnColumn
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 9
            .DIVID = "divList"
            .DIVHeight = 600
            .DIVStyle = "overflow:auto;width:100%;"
            .PrimaryKey = "IRID"
            '.RowLinkArray = arrRowLink
            '.GroupSummaryFunc = ArrGroupSummaryFunctions
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub

    Private Sub objProjectGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objProjectGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 4 Then
            If mode1 <> "ClosedProjects" Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub objProjectGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objProjectGrid.DataRowTD_BeforePrint
        'If Args.ColIndex = 0 Then 'if first column(Employee Name)

        '    'Determine stylesheet for row
        '    If Args.NoOfRowsPrinted Mod 2 = 0 Then
        '        'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
        '        Args.StringToBeInserted = "<TD align='left'></TD>"
        '    Else
        '        Args.StringToBeInserted = "<TD align='left'></TD>"
        '    End If
        '    Cancel = True
        'End If
        If Args.ColIndex = 4 Then
            If mode1 <> "ClosedProjects" Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub objProjectGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objProjectGrid.DataRowTR_BeforePrint
        'If m_CustomerName <> Args.DataReader("CustomerNAME").ToString.Trim Then
        '    m_CustomerName = Args.DataReader("CustomerNAME").ToString.Trim + ""
        '    If mode1 = "ClosedProjects" Then
        '        Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=6>" + Args.DataReader("CustomerNAME").ToString + "</FONT></TD></TR>"
        '    Else
        '        Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=5>" + Args.DataReader("CustomerNAME").ToString + "</FONT></TD></TR>"
        '    End If
        'End If
    End Sub

    Private Sub objSOAGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objSOAGrid.DataRowTD_BeforePrint
        'If Args.ColIndex = 0 Then 'if first column(Employee Name)

        '    'Determine stylesheet for row
        '    If Args.NoOfRowsPrinted Mod 2 = 0 Then
        '        'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
        '        Args.StringToBeInserted = "<TD align='left'></TD>"
        '    Else
        '        Args.StringToBeInserted = "<TD align='left'></TD>"
        '    End If
        '    Cancel = True
        'End If
    End Sub

    Private Sub objSOAGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objSOAGrid.DataRowTR_BeforePrint
        If m_CustomerName <> Args.DataReader("Customer").ToString.Trim Then
            m_CustomerName = Args.DataReader("Customer").ToString.Trim + ""
            If m_intGroupNumber = -1 Then
                m_GroupTotal += CType(Args.DataReader("InvoiceAmount"), Double)
                m_GroupTotal1 += CType(Args.DataReader("ReceiptAmount"), Double)
                'm_GroupTotal2 += CType(Args.DataReader("OutstandingAmount"), Double)
            End If

            m_intGroupNumber += 1
            If m_intGroupNumber = 1 Then
                m_GroupTotal2 += CType(Args.DataReader("OutstandingAmount"), Double)
            End If

            If m_GroupTotal >= 0 Then
                If m_intGroupNumber <> 0 Then
                    Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD colspan=4><B>Total</B></TD><TD align=right width=15% >" + FormatNumber(m_GroupTotal, 2).ToString + "</TD><TD align=right width=15% >" + FormatNumber(m_GroupTotal1, 2).ToString + "</TD><TD align=right width=15% >" + FormatNumber(m_GroupTotal2, 2).ToString + "</TD><TD>&nbsp;</TD></TR>"
                    'Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align=right colspan=7 width=15% >" + FormatNumber(m_GroupTotal1, 2).ToString + "</TD><TD colspan=2></TD></TR>"
                    'Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align=right colspan=8 width=15% >" + FormatNumber(m_GroupTotal2, 2).ToString + "</TD><TD colspan=1></TD></TR>"
                End If
            End If
            'If m_GroupTotal1 >= 0 Then
            '    If m_intGroupNumber <> 0 Then
            '        Args.StringToBeInserted = "<TD align=right colspan=7 width=15% >" + FormatNumber(m_GroupTotal1, 2).ToString + "</TD><TD colspan=2></TD>"
            '    End If
            'End If
            'If m_GroupTotal2 >= 0 Then
            '    If m_intGroupNumber <> 0 Then
            '        Args.StringToBeInserted = "<TD align=right colspan=8 width=15% >" + FormatNumber(m_GroupTotal2, 2).ToString + "</TD><TD colspan=1></TD></TR>"
            '    End If
            'End If
            m_GroupTotal = 0
            m_GroupTotal1 = 0
            m_GroupTotal2 = 0
            m_GroupTotal += CType(Args.DataReader("InvoiceAmount"), Double)
            m_GroupTotal1 += CType(Args.DataReader("ReceiptAmount"), Double)
            m_GroupTotal2 = CType(Args.DataReader("OutstandingAmount"), Double)
            'Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=9>" + Args.DataReader("Customer").ToString + "</FONT></TD></TR>"

        Else
            m_GroupTotal += CType(Args.DataReader("InvoiceAmount"), Double)
            m_GroupTotal1 += CType(Args.DataReader("ReceiptAmount"), Double)
            m_GroupTotal2 = CType(Args.DataReader("OutstandingAmount"), Double)
        End If
    End Sub

    Private Sub objSOAGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objSOAGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 4 Then
            Args.StringToBeInserted = "<TD align=right>" + ("TOTAL") + "</TD>"
            Cancel = True
        End If
    End Sub

    Private Sub objSOAGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles objSOAGrid.SummaryFunctionsTR_BeforePrint
        m_intGroupNumber += 1


        If m_GroupTotal >= 0 And m_CustomerName <> "" Then
            Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD colspan=4><B>Total</B></TD><TD align=right width=15% >" + FormatNumber(m_GroupTotal, 2).ToString + "</TD><TD align=right width=15% >" + FormatNumber(m_GroupTotal1, 2).ToString + "</TD><TD align=right width=15% >" + FormatNumber(m_GroupTotal2, 2).ToString + "</TD><TD>&nbsp;</TD></TR>"
        End If
    End Sub
    Private Sub objUpcomingInvoicesGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objUpcomingInvoicesGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then 'if first column(Employee Name)

            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                Args.StringToBeInserted = "<TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TD align='left'></TD>"
            End If
            Cancel = True
        End If
    End Sub
    Private Sub objUpcomingInvoicesGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objUpcomingInvoicesGrid.DataRowTR_BeforePrint
        If m_ProjectName <> Args.DataReader("ProjectName").ToString.Trim Then
            m_ProjectName = Args.DataReader("ProjectName").ToString.Trim + ""

            Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left'></TD><TD align='left' colspan=6>" + Args.DataReader("ProjectName") + "</TD></TR>"

        End If
    End Sub
End Class