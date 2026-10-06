Imports CommonEngines.General.cEventHandlers
Public Class Alerts_CommonList
    Inherits CommonList



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
        MyBase.strListPage = "Alerts_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cAlert_CommonListGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cAlerts_CommonListSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub OnPreRender(ByVal e As System.EventArgs)
        CommonFunction.General.WriteHTML("<script>")
        CommonFunction.General.WriteHTML("function openHelpDeskReq(id,pkToken)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("window.open (""../CRM/CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=MD&QueryID=""+id+""&PKToken=""+pkToken,"""",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=380"");")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("</script>")

    End Sub
End Class
Public Class cAlert_CommonListGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "FLAG" Then
            Dim Contextid As String
            Dim Projectid As String
            Dim Employeeid As String
            Dim Contexttype As String
            Dim EntityName As String
            Dim m_strToken As String
            Dim Flag As String
            Contextid = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Contextid"), "0"), String)
            Projectid = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Projectid"), "0"), String)
            Employeeid = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Employeeid"), "0"), String)
            Contexttype = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Contexttype"), "0"), String)
            ''Added By Nilesh g on 1/3/2016 for token generation
            'm_strToken = CommonFunctions.Security.Token.GetToken(CType(Contextid, String) + CType(Projectid, String) + CType(Employeeid, String) + "0" + "0")

            m_strToken = CommonFunctions.Security.Token.GetToken(CType(Projectid, String) + CType(Employeeid, String) + "0" + "0" + CType(Contextid, String))

            EntityName = ""
            Flag = "Flag"
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "0"), String) = "1" Then
                Flag = "Review"
            ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "0" Then
                Flag = "Follow Up"
            End If

            Cancel = True
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DueDateState"), ""), String) = "S" Then

                ''Commented and added by Nilesh g on 1/3/2016 for add PkToken
                ''Args.StringToBeInserted = "<TD><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + Flag + "' onclick="""" ></a></TD>"
                Args.StringToBeInserted = "<TD><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + m_strToken + "'" + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + Flag + "' onclick="""" ></a></TD>"


            ElseIf CType(Args.DataReader("DueDateState"), String) = "L" Then
                ''Commented and added by Nilesh g on 1/3/2016 for add PkToken
                ''  Args.StringToBeInserted = "<TD><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/RedFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>"
                Args.StringToBeInserted = "<TD><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + m_strToken + "'" + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/RedFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>"


            ElseIf CType(Args.DataReader("DueDateState"), String) = "G" Then
                ''Commented and added by Nilesh g on 1/3/2016 for add PkToken
                ''  Args.StringToBeInserted = "<TD><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/GreenFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>"
                Args.StringToBeInserted = "<TD><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + m_strToken + "'" + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/GreenFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>"
                'Added By ShraddhaM on 13,Aug 2007
                'Purpose : To display black flag when flag is completed
            ElseIf CType(Args.DataReader("DueDateState"), String) = "B" Then
                ''Commented and added by Nilesh g on 1/3/2016 for add PkToken
                ''  Args.StringToBeInserted = "<TD><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/BlackFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>"
                Args.StringToBeInserted = "<TD><a href=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + m_strToken + "'" + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )""><IMG Border=0  SRC='../../Images/BlackFlag.gif' title='" + Flag + "' onclick="""" ></a></TD>"
                'End of Addition By shraddhaM on 13,Aug 2007
            End If
        End If

        If Args.DataField.ToUpper = "CONTEXTTYPECHAR" Then
            Dim ContextC As String
            ContextC = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ContextTypeChar"), ""), String)
            Cancel = True
            Select Case ContextC
                Case "D"
                    Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/D.gif'  title='Deliverable' ></A></TD>"
                Case "H"
                    Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/H.gif'  title='Help Request' ></A></TD>"
                Case "I"
                    Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/I.gif'  title='Issue' ></A></TD>"
                Case "M"
                    Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/M.gif'  title='Milestone' ></A></TD>"
                Case "R"
                    Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/R.gif'  title='Risk' ></A></TD>"
                Case "T"
                    Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/T.gif'  title='Task' ></A></TD>"
                Case "W"
                    Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/W.gif'  title='Review' ></A></TD>"

            End Select
        End If
        If Args.DataField.ToUpper = "ID" Then
            'Added by PrashantD on 05 Jun 2007 for CleanUp Activity
            If Args.DataReader("ContextTypeChar").ToString = "H" Then
                Dim strPKToken As String
                strPKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ID"), String) + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "0")
                Cancel = True
                Args.StringToBeInserted = "<TD align=Center> <A HREF=""JAVASCRIPT:openHelpDeskReq('" + Args.DataReader("ID").ToString + "','" + strPKToken + "')""> " + Args.DataReader("ID").ToString + "</A> </TD>"
            End If
            'End of addition by PrashantD on 05 Jun 2007
            Dim EID As String
            EID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ID"), "0"), String)
            If EID = "0" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=Center> - </TD>"
            End If
        End If
        If Args.ColumnName.ToUpper = "RESOURCE" Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String) = "" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=Left> - </TD>"
            End If
        End If
        If Args.DataField.ToUpper = "PROJECTNAME" Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String) = "" Then
                Cancel = True
                Args.StringToBeInserted = "<TD>N/A</TD>"
            End If
        End If
    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim strScript As String = ""
        strScript = vbCrLf & "<Script Language=Javascript>" & vbCrLf
        ''Commented and added by Nilesh g on 1/3/2016 for add PkToken
        ''strScript &= "function FlagSet(intProjectID,intContextid,intEmployeeid,strContexttype,strEntityName)" & vbCrLf
        strScript &= "function FlagSet(intProjectID,intContextid,intEmployeeid,m_strToken,strContexttype,strEntityName)" & vbCrLf
        strScript &= "{  " & vbCrLf
        'strScript &= "window.open (""../DB/DB_TrackingDetails.aspx?ProjectID=123,_blank,resizable=yes,scrollbars=no,left="" + (window.screen.width - 540)/2 + "",top="" + (window.screen.height - 430)/2 + "",width=420,height=300"" );" & vbCrLf
        ''Commented and added by Nilesh g on 1/3/2016 for add PkToken
        ''strScript &= " window.open (""../DB/DB_TrackingDetails.aspx?ProjectID="" + intProjectID + ""&ContextID="" + intContextid + ""&EmployeeID="" + intEmployeeid + ""&ContextType=""+ strContexttype +""&FromWhich=FlagTrack&ContextName="" + strEntityName ,""_blank"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 540)/2 + "",top="" + (window.screen.height - 430)/2 + "",width=420,height=300"" ); " & vbCrLf
        strScript &= " window.open (""../DB/DB_TrackingDetails.aspx?ProjectID="" + intProjectID + ""&ContextID="" + intContextid + ""&EmployeeID="" + intEmployeeid + ""&PKToken="" + m_strToken + ""&ContextType=""+ strContexttype +""&FromWhich=FlagTrack&ContextName="" + strEntityName ,""_blank"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 540)/2 + "",top="" + (window.screen.height - 430)/2 + "",width=420,height=300"" ); " & vbCrLf
        strScript &= "}  " & vbCrLf
        strScript = strScript & vbCrLf & "</Script >" & vbCrLf
        Args.ToBeInserted = strScript
        ' End Of Addition by SrikanthY
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "DURATION" Then
            Cancel = True
            Args.StringToBeInserted = "<TH class=''divListTag'' align=''Left''></TH>"
        End If
    End Sub
End Class

Public Class cAlerts_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String

        GetPageSpecificFilters += " AND ID<>0 AND EmployeeID=" & HttpContext.Current.Session("intUserID").ToString
    End Function
End Class