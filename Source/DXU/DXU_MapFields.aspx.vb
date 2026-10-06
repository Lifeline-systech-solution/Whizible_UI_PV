Public Class DXU_MapFields
    Inherits WebPages.Template.WhizTemplate

    'Added by HemantB - 17th Feb
    Protected m_strPrimaryKey As String

    Protected m_intMandatoryFldsCnt As Integer
    Protected m_intPrimaryKeyOrderNo As Integer = 0

    Protected m_intTemplateId As Integer
    Protected m_strMode As String
    Protected strMatchFld As String
    Protected m_SQLCommand As System.Data.SqlClient.SqlCommand
    Protected m_objConnection As CommonFunctions.Connection
    Protected m_strWindowTitle As String
    Protected WithEvents objgrid As WebPages.Template.GenericGrid
    Protected WithEvents objMenu As WebPages.Template.StaticMenu
    Protected WithEvents objHeaderFooter As WebPages.Template.HeaderFooter
    Protected strComboSQL As String
    Protected strUpdateSQL As String
    Protected strMapSQL As String
    Protected m_objDataReader As IDataReader
    Protected m_objData As CommonFunctions.Data
    Protected m_strTemplateFieldName As String
    Private m_EntityID As Integer


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
        'Put user code to initialize the page here


        m_SQLCommand = New System.Data.SqlClient.SqlCommand
        m_SQLCommand.Connection = m_objConnection.GetSQLConnection(CommonFunction.General.GetConnectionString())
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE")

        If Not Request.QueryString("TemplateId") Is Nothing Then
            m_intTemplateId = CType(Request.QueryString("TemplateID"), Integer)
        Else
            m_intTemplateId = 46
        End If
        m_intMandatoryFldsCnt = 0

        'Added by HemantB - 17th Feb 
        If Not Request.QueryString("PrimaryKeyName") Is Nothing Then
            m_strPrimaryKey = Request.QueryString("PrimaryKeyName")
        Else
            m_strPrimaryKey = ""
        End If


    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draws the page with its 
    '                           controls on it. This procedure is called from the HTML body tag of the page.
    '                           This procedure gives call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	HemantB
    ' Created				:	Dec 08 2004
    ' Revisions				:	
    '=====================================================================
    Sub PageInit()

        'Get entity for the template
        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'm_EntityID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select ENtityID from tbl_DXU_TemplateMaster where TemplateID = " + m_intTemplateId.ToString, MyBase.UseSQL), "0"), Integer)
        m_EntityID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_DXU_TemplateMaster_ENtityID " + m_intTemplateId.ToString, MyBase.UseSQL), "0"), Integer)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        Dim strMenu As String

        MyBase.ApplySecurity(True)


        objMenu = New WebPages.Template.StaticMenu

        Dim arrNames() As String = {"Save", "Close"}
        Dim arrMenuToolTip() As String = {"Save", "Close"}
        Dim arrFunction() As String = {"Save_onclick()", "Cancel_onclick()"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        strMenu = objMenu.DrawMenuWithEvents(arrNames, arrFunction, arrMenuToolTip)
        Response.Write(strMenu)


        'header footer

        objHeaderFooter = New WebPages.Template.HeaderFooter
        With objHeaderFooter
            .HeaderFooter = "Map Fields"
            .DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
        End With
        Response.Write("<br>")
        Response.Write(objHeaderFooter.DrawHeaderFooter())
        Response.Write("<br>")
        objHeaderFooter = Nothing



        objgrid = New WebPages.Template.GenericGrid
        'User Defined Column Name
        'code commented by SandipL whizengg team For DXU Enhancements
        ' Dim arrUserFriendly() As String = {"Entity Field Name", "Template Field Name", "Entity Field Data type", "Look Up", "Use for Task creation"}
        'Actual Column name 
        'Dim arrActual() As String = {"UserFriendlyName", "", "DataType", "", "UsedForTaskCreation"}
        Dim arrUserFriendly() As String = {"Entity Field Name", "Template Field Name", "Entity Field Data type", "Look Up"}
        'Actual Column name 
        Dim arrActual() As String = {"UserFriendlyName", "", "DataType", ""}
        'CheckBox
        Dim arrCheckBox() As String = {"", "", "", "", "chkTaskCreation"}
        'Dim arrCheck() As String = {"", "", "IsSelected"}
        'RowLink
        Dim arrRowLink() As String = {"", "", "", "", ""}
        'Summary
        Dim arrSummary() As String = {"", "", "", "", ""}
        'TD Style
        Dim arrTDStyle() As String = {"align=left", "align=center", "align=center", "align=center", "align=center"}
        Dim strSortBy, strSortOrder As String

        With objgrid
            .UserFriendlyColumnArray = arrUserFriendly
            .ActualColumnArray = arrActual
            ' .CheckBoxIDArray = arrCheckBox
            .DIVID = "DivList"
            .DIVHeight = 500
            .DIVStyle = "overflow: auto"
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .RowLinkArray = arrRowLink
            .UseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
            .SQL = "SELECT * FROM " _
                           & " tbl_dxu_entitydetails, tbl_dxu_templatedetails, tbl_DXU_LookUp" _
                           & " WHERE  tbl_dxu_entitydetails.FieldID *= tbl_dxu_templatedetails.ActualFieldId" _
                           & " AND tbl_dxu_entitydetails.FieldID  *= tbl_DXU_LookUp.DestinationFieldID" _
                           & " AND tbl_dxu_entitydetails.EntityID = (SELECT EntityId FROM tbl_DXU_TemplateMaster" _
                           & " WHERE tbl_DXU_TemplateMaster.TemplateID = " & m_intTemplateId & ")" _
                           & " AND tbl_dxu_templatedetails.TemplateID = " & m_intTemplateId _
                           & " AND tbl_DXU_LookUp.TemplateID = " & m_intTemplateId _
                           & " AND Show = 1" _
                           & " ORDER BY tbl_dxu_entitydetails.IsMandatory DESC, FieldID ASC"
            .PrimaryKey = "FieldId"
            .NoOfDataColumns = 3
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        End With

        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hdntxtTemplateID", "hdntxtTemplateID", IsHidden:=True, returnHTML:=True, value:=CType(m_intTemplateId, String), EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Dim strgrid As String = objgrid.DrawGrid()
        Response.Write(strgrid)

        'redraw menu
        Response.Write("<BR>")
        Response.Write(strMenu)
        'If HttpContext.Current.Request("Mode") = "Save" Then
        '    Response.Write("<script> window.opener.location.href = window.opener.location.href;</script>")
        'End If
    End Sub

    Private Sub objgrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objgrid.DataRowTD_BeforePrint

        Dim strLookUpToolTip As String
        Dim blnIsLookUp As Boolean = False

        Select Case Args.ColumnName

            Case "Entity Field Data type"
                'Args.StringToBeInserted = Args.DataReader("DataType")
            Case "Entity Field Name"

                If CType(Args.DataReader("IsMandatory"), Boolean) Or CType(Args.DataReader("FieldName"), String) = m_strPrimaryKey Then 'Or condition added by HemantB - 17th Feb
                    Args.StringToBeInserted = "<TD>" & "<Font color=red>" & CType(Args.DataFieldValue, String) & "</font>" & "</TD>"
                    Cancel = True
                End If

            Case "Use for Task creation"
                If CInt(Args.DataReader("EntityID")) <> 1 Then
                    Cancel = True
                    Exit Select
                End If

                If HttpContext.Current.Request.QueryString("Mode") <> "Save" Then
                    If Not IsDBNull(Args.DataReader("UsedForTaskCreation")) AndAlso CType(Args.DataReader("UsedForTaskCreation"), Boolean) = True Then
                        Args.StringToBeInserted = "<TD align = 'center'>" & "<Input Type='radio' name ='UsedForTaskCreation' id='UsedForTaskCreation' checked value ='" & CType(Args.DataReader("FieldID"), String) & "' />" & "</TD>"
                    Else
                        Args.StringToBeInserted = "<TD align = 'center'>" & "<Input Type='radio' name ='UsedForTaskCreation' id='UsedForTaskCreation' value ='" & CType(Args.DataReader("FieldID"), String) & "' />" & "</TD>"
                    End If
                Else
                    If (Not Request.Form("UsedForTaskCreation") Is Nothing) AndAlso CType(MyBase.GetFormValue("UsedForTaskCreation"), Integer) = CType(Args.DataReader("FieldID"), Integer) Then
                        Args.StringToBeInserted = "<TD align = 'center'>" & "<Input Type='radio' name ='UsedForTaskCreation' id='UsedForTaskCreation' checked value ='" & CType(Args.DataReader("FieldID"), String) & "' />" & "</TD>"
                    Else
                        Args.StringToBeInserted = "<TD align = 'center'>" & "<Input Type='radio' name ='UsedForTaskCreation' id='UsedForTaskCreation' value ='" & CType(Args.DataReader("FieldID"), String) & "' />" & "</TD>"
                    End If
                End If
                Cancel = True

            Case "Template Field Name"
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strComboSQL = "Select TemplateDetailId, TemplateFieldName from tbl_DXU_TemplateDetails where TemplateId = " & m_intTemplateId & " And Isnull(ActualExcelColName,'0') <> 'NULL' Order By TemplateFieldName"
                strComboSQL = "usp_sel_tbl_DXU_TemplateDetails_TemplateDetailId_TemplateFieldName " & m_intTemplateId
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                'If Args.IsCheckBoxChecked = True Then

                If HttpContext.Current.Request.QueryString("Mode") = "Save" Then
                    'strComboSQL = "Select TemplateDetailId, TemplateFieldName from tbl_DXU_TemplateDetails where TemplateId = " & m_intTemplateId & "  and ActualExcelColName is not null Order By TemplateFieldName "
                    m_strMode = "Save"
                    strMatchFld = MyBase.GetFormValue("cboSourceFldName" & Args.NoOfRowsPrinted)
                    'If (InStr("," & MyBase.GetFormValue("chkPerm") & ",", "," & CStr(Args.DataReader("FieldId")) & ",") > 0 And Not strMatchFld Is Nothing) Then
                    If Not strMatchFld Is Nothing AndAlso strMatchFld <> "" Then
                        'If mapping the same TemplateField to more than one fields in the entity table,insert a new
                        'record into tbl_DXU_TemplateDetails table.

                        strMapSQL = "Select * from tbl_DXU_TemplateDetails where"
                        strMapSQL &= " TemplateID = " & m_intTemplateId
                        strMapSQL &= " and ActualFieldID = " & CType(Args.DataReader("FieldID"), String)

                        m_objDataReader = m_objData.GetDataReader(strMapSQL, True)
                        If m_objDataReader.Read = True Then  'Overwriting the mapping.
                            strUpdateSQL = "update tbl_dxu_TemplateDetails set ActualFieldName = NULL,"
                            strUpdateSQL &= "ActualFieldID = NULL,DataType = NULL"
                            strUpdateSQL &= " where TemplateID =" & m_intTemplateId
                            strUpdateSQL &= " and ActualFieldID = " & CType(m_objDataReader.Item("ActualFieldID"), String)
                            m_SQLCommand.CommandText = strUpdateSQL
                            m_SQLCommand.ExecuteNonQuery()
                            m_objDataReader.Close()
                        End If

                        strMapSQL = "Select * from tbl_DXU_TemplateDetails where"
                        strMapSQL &= " TemplateID = " & m_intTemplateId
                        strMapSQL &= " and TemplateDetailId = " & strMatchFld
                        strMapSQL &= " and ActualFieldID is not NULL"

                        m_objDataReader = m_objData.GetDataReader(strMapSQL, True)
                        If m_objDataReader.Read = False Then
                            strUpdateSQL = "update tbl_dxu_TemplateDetails set ActualFieldName = '" & CType(Args.DataReader("FieldName"), String) & "'"
                            strUpdateSQL &= ",ActualFieldID = " & CType(Args.DataReader("FieldID"), String)
                            strUpdateSQL &= ",DataType = '" & CType(Args.DataReader("DataType"), String) & "'"
                            'Update the UsedForTaskCreation flag
                            If (Not Request.Form("UsedForTaskCreation") Is Nothing) AndAlso CType(MyBase.GetFormValue("UsedForTaskCreation"), Integer) = CType(Args.DataReader("FieldID"), Integer) Then
                                strUpdateSQL &= " , UsedForTaskCreation = 1 "
                            Else
                                strUpdateSQL &= " , UsedForTaskCreation = 0 "
                            End If

                            strUpdateSQL &= " where TemplateId = " & m_intTemplateId
                            strUpdateSQL &= " and TemplateDetailId = " & strMatchFld
                        Else ' OverWriting the same mapping or mapping the same Template field to another Entity.
                            strUpdateSQL = "insert into tbl_dxu_TemplateDetails "
                            strUpdateSQL &= "(TemplateID,TemplateFieldName,ActualFieldName,ActualFieldID,DataType,ActualExcelColName,UsedForTaskCreation) values "
                            strUpdateSQL &= "(" & m_intTemplateId & ",'" & CType(m_objDataReader.Item("TemplateFieldName"), String) & "','"
                            strUpdateSQL &= CType(Args.DataReader("FieldName"), String) & "'," & CType(Args.DataReader("FieldID"), String) & ",'"
                            strUpdateSQL &= CType(Args.DataReader("DataType"), String) & "', '" & CType(Args.DataReader("ActualExcelColName"), String) & "'"
                            'Update the UsedForTaskCreation flag
                            'If CType(MyBase.GetFormValue("UsedForTaskCreation"), Integer) = CType(Args.DataReader("FieldID"), Integer) Then
                            '    strUpdateSQL &= " ,  1 )"
                            'Else
                            strUpdateSQL &= " ,  0)"
                            'End If

                        End If
                        m_SQLCommand.CommandText = strUpdateSQL
                        m_SQLCommand.ExecuteNonQuery()
                        m_objDataReader.Close()

                        'strUpdateSQL = "delete from tbl_DXU_TemplateDetails where "
                        'strUpdateSQL &= "ActualFieldID = " & Args.DataReader("FieldID")
                        'strUpdateSQL &= " and TemplateDetailID <> " & strMatchFld
                    Else
                        If Args.DataReader("ActualFieldName") Is Nothing Or Args.DataReader("ActualFieldName") Is DBNull.Value Then

                        Else

                            strUpdateSQL = "update tbl_dxu_TemplateDetails set ActualFieldName = 'NULL',"
                            strUpdateSQL &= "ActualFieldID = NULL,ActualExcelColName = 'NULL',IsLookUp=0 "
                            strUpdateSQL &= " where TemplateID =" & m_intTemplateId
                            strUpdateSQL &= " and ActualFieldID = " & CType(Args.DataReader("ActualFieldID"), String)
                            m_SQLCommand.CommandText = strUpdateSQL
                            m_SQLCommand.ExecuteNonQuery()
                        End If
                    End If
                Else
                    strMatchFld = ""
                    If Not IsDBNull(Args.DataReader("TemplateDetailID")) Then
                        strMatchFld = CType(Args.DataReader("TemplateDetailID"), String)
                    Else
                        strMatchFld = ""
                    End If
                    m_strMode = "Map"
                End If


                If CType(Args.DataReader("IsMandatory"), Boolean) = True Or CType(Args.DataReader("FieldName"), String) = m_strPrimaryKey Then 'Or condition added by HemantB - 17th Feb
                    Args.StringToBeInserted = "<TD>" & CommonFunctions.HTMLControls.DrawComboBox("cboSourceFldName" & Args.NoOfRowsPrinted, strComboSQL, 120, strMatchFld, "onchange=cbo_onchange(" & Args.NoOfRowsPrinted & ",'Y')", True, True, "clsComboBox", True) & "</TD>"
                    m_intMandatoryFldsCnt += 1
                    If CType(Args.DataReader("FieldName"), String) = m_strPrimaryKey Then
                        m_intPrimaryKeyOrderNo = CType(Args.NoOfRowsPrinted, Integer)
                    End If
                Else
                    Args.StringToBeInserted = "<TD>" & CommonFunctions.HTMLControls.DrawComboBox("cboSourceFldName" & Args.NoOfRowsPrinted, strComboSQL, 120, strMatchFld, "onchange=cbo_onchange(" & Args.NoOfRowsPrinted & ",'N')", True, True) & "</TD>"
                End If

                Cancel = True

            Case "Look Up"
                Dim strSQL_MappedCount As String
                strSQL_MappedCount = "SELECT TemplateDetailID From tbl_DXU_TemplateDetails "
                strSQL_MappedCount += " Where ActualFieldID IS NOT NULL AND TemplateID = " + CType(m_intTemplateId, String)
                m_objDataReader = m_objData.GetDataReader(strSQL_MappedCount, True)
                If m_objDataReader.Read = True Then
                    If Not IsDBNull(Args.DataReader("LookUpTable")) Then
                        strLookUpToolTip = "Table Name : " & CType(Args.DataReader("LookUpTable"), String) & vbCrLf
                        strLookUpToolTip += "Column To Match : " & CType(Args.DataReader("LookUpMatchField"), String) & vbCrLf
                        strLookUpToolTip += "Value From Column : " & CType(Args.DataReader("LookUpValue"), String)
                        blnIsLookUp = True
                    End If
                    If CType(Args.DataReader("DataType"), String).ToUpper = "NUMBER" Or CType(Args.DataReader("DataType"), String).ToUpper = "INT" Then
                        Args.StringToBeInserted = "<TD>" & "<A title='" & strLookUpToolTip & "' HREF='#' onclick=lookup_onclick(" & CType(Args.DataReader("FieldID"), String) & ",'" & CType(Args.DataReader("DataType"), String) & "','" & blnIsLookUp & "'" _
                                                                        & "," & Args.NoOfRowsPrinted _
                                                                        & ") >Look Up</A>" & "</TD>"
                    Else
                        Args.StringToBeInserted = "<TD></TD>"
                    End If

                    '& ", '" & "false" &"'"_
                    strLookUpToolTip = ""
                    blnIsLookUp = False
                    Cancel = True
                    m_objDataReader.Close()
                End If
        End Select
    End Sub


    Private Sub objgrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objgrid.ColumnHeaderTD_BeforePrint
        If m_EntityID <> 1 And Args.ColIndex = 4 Then
            Cancel = True
        End If
    End Sub

    Private Sub objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles objMenu.Before_Link_Print

        If Args.LinkName.ToUpper = "SAVE" Then
            Dim strSQL As String
            Dim intCount As Integer
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "Select Count(1) From tbl_DXU_UploadRequestsQueue Where TemplateID= " & CStr(m_intTemplateId) & " And (Status='I' OR Status='A' OR Status='B') "
            strSQL = "usp_sel_tbl_DXU_UploadRequestsQueue_CountRequestID " & CStr(m_intTemplateId)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            intCount = CType(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), Integer)
            If intCount > 0 Then
                Cancel = True
            End If

        End If
    End Sub

   
End Class
