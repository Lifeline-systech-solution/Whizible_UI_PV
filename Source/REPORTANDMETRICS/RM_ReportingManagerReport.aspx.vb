'Note:  Do not forget to change the Namespce of the ASPX page, to that of your solution.
'       Remove the events/overridden methods which are not used.


Imports System.Text
Imports CommonFunctions.General
Imports Utilities.Security.SecurityBuilder

Public Class RM_ReportingManagerReport
    'TODO: Set the class name accordingly
    Inherits Whiz.CRW_ReportUIBuilder


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

#Region "Page Related Events"

    Protected Overrides Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        ' Set the SubmitToPage, so that onChange of a dependent combo-box or in view mode,
        ' this page will submit to itself.
        'e.g.
        'MyBase.SubmitToPage = "../My_Folder/My_ReportUIBuilder.aspx"

        'TODO: Set the ASPX path accordingly.
        ' Added By Sanyogeeta on 10-10-2016  For Apply Security
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Apply Security
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function PagePreRender() As String
        ' You can response.Write some JavaScript before the rendering of page starts.
        ' Or you can return the Script as a string.
        ' Note: Do not forget to include the script within the <script> tag.
        ' Comment the following line if you use this overridden method.
        Return MyBase.PagePreRender()
    End Function

    Protected Overrides Function PagePostRender() As String
        ' You can Response.Write some JavaScript after the rendering of page is finished.
        ' Or you can return the Script as a string.
        ' Note: Do not forget to include the script within the <script> tag.
        ' Comment the following line if you use this overridden method.

        Return MyBase.PagePostRender()
    End Function

#End Region

#Region "Events for Controls"
    'Note: In the following events [prefixed with "Before_Plot"], currently "Cancel" is not in use.
    'The name of the events are self explanatory
    'The whole control cell is plotted like following (Here, the ids are provided for reference only):

    '<TD id='tdCaption'> CaptionText </TD>
    '<TD id='tdControl'> ControlHtml </TD>

    'e.g. 
    '<TD> Employee </TD>
    '<TD> <input type='text' id='strEmployee' value=''> </TD>

    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByVal Args As AdHocReports.UI.ReportUIControlArgs)
        'First event to get fired for a control.
        'From this event Args.StringToBeInserted is used.
        'If Args.StringToBeInserted is not blank then it is written on response,
        'before plotting the opening tag of td having id='tdCaption'.

        'Please comment the following code if you want to use this overriden method.
        MyBase.Before_PlotControlCell(Cancel, Args)
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByVal Args As AdHocReports.UI.ReportUIControlArgs)
        'Second event to get fired for a control.
        'From this event Args.InsertBeforeControlCaption is used.
        'If Args.InsertBeforeControlCaption is not blank then it is written on response,
        'before plotting the CaptionText within the td having id='tdCaption'.

        'Please comment the following code if you want to use this overriden method.
        MyBase.Before_PlotControlCaption(Cancel, Args)
    End Sub

    Protected Overrides Sub After_PlotControlCaption(ByVal Args As AdHocReports.UI.ReportUIControlArgs)

        'Third event to get fired for a control.
        'From this event Args.InsertAfterControlCaption is used.
        'If Args.InsertAfterControlCaption is not blank then it is written on response,
        'after plotting the CaptionText within the td having id='tdCaption'.

        'Please comment the following code if you want to use this overriden method.
        MyBase.After_PlotControlCaption(Args)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByVal Args As AdHocReports.UI.ReportUIControlArgs)

        'Fourth event to get fired for a control.
        'From this event Args.InsertBeforeControl, Args.StringToBeInserted, Args.ReplacementValue,
        'Args.ClientSideScriptToInsert, Args.ScriptToBeInsertedInFunction are used.

        'If Args.InsertBeforeControl is not blank then it is written on response,
        'before plotting the ControlHtml within td having id='tdControl'.


        ' If you want to send some ToBeInserted string to the html control, use Args.StringToBeInserted
        ' For a textbox we use CommonFunctions.HTMLControls.DrawTextBox function which has "ToBeInserted"
        ' parameter which is a string. The Args.StringToBeInserted will be passed to this function as it is.
        ' e.g.
        ''If Args.ReportUIControlHashTableObject.ReportID = 1000 AndAlso Args.ReportUIControlHashTableObject.ControlName = "txtAmount" Then
        ''    Args.StringToBeInserted = " onblur='JavaScript:Amount_OnBlur(this)' "
        ''End If
        ' Note: Please Response.Write the Amount_OnBlur JS function in Prerender/PostRender event.


        ' If you want to apply some default value to the control then use Args.ReplacementValue
        ' e.g.
        ''If IsPostBack = False AndAlso Args.ReportUIControlHashTableObject.ReportID = 786 AndAlso Args.ReportUIControlHashTableObject.ControlName = "dtFrom" Then
        ''    Args.ReplacementValue = Now.ToString
        ''End If


        ' If you want to apply some custom validation then use Args.ClientSideScriptToInsert
        ' e.g.
        ''If IsPostBack = False AndAlso Args.ReportUIControlHashTableObject.ReportID = 786 AndAlso Args.ReportUIControlHashTableObject.ControlName = "strUserName" Then
        ''    Dim sbClientSideScriptToInsert As New StringBuilder
        ''    sbClientSideScriptToInsert.Append("var obj")
        ''    sbClientSideScriptToInsert.Append(Args.ReportUIControlHashTableObject.ControlName)
        ''    sbClientSideScriptToInsert.Append("=GetObjectReference('','")
        ''    sbClientSideScriptToInsert.Append(Args.ReportUIControlHashTableObject.ControlName)
        ''    sbClientSideScriptToInsert.Append("');")
        ''    sbClientSideScriptToInsert.Append(vbCrLf)
        ''    sbClientSideScriptToInsert.Append("if (obj") : sbClientSideScriptToInsert.Append(Args.ReportUIControlHashTableObject.ControlName)
        ''    sbClientSideScriptToInsert.Append(".value.toString()=='61') {alert('Select employee other than \'Admin\''); return;}")
        ''    sbClientSideScriptToInsert.Append(vbCrLf)
        ''    Args.ClientSideScriptToInsert = sbClientSideScriptToInsert.ToString
        ''End If

        'Please comment the following code if you want to use this overriden method.


        ' If you want to disable the control then use Args.IsDisabled
        'In this case, if the control is mandatory then please do not forget to assign default value
        ' e.g.
        ''If IsPostBack = False AndAlso Args.ReportUIControlHashTableObject.ReportID = 785 Then
        ''    If Args.ReportUIControlHashTableObject.ControlName = "dtFrom" Then
        ''        Args.ReplacementValue = Now.ToString
        ''        Args.IsDisabled = True
        ''    ElseIf Args.ReportUIControlHashTableObject.ControlName = "strUserName" Then
        ''        Args.ReplacementValue = CheckIsNothing(Session("intUserID"))
        ''        Args.IsDisabled = True
        ''    End If
        ''End If
        If Args.ReportUIControlHashTableObject.ReportID = 2525 Or Args.ReportUIControlHashTableObject.ReportID = 2527 Then
            If Args.ReportUIControlHashTableObject.ControlName = "strStartDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "strEndDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 1841 Then
            If Args.ReportUIControlHashTableObject.ControlName = "strStartDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "strEndDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 1861 Then
            If Args.ReportUIControlHashTableObject.ControlName = "strStartDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "strEndDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 1839 Then
            If Args.ReportUIControlHashTableObject.ControlName = "strStartDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "strEndDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 1840 Then
            If Args.ReportUIControlHashTableObject.ControlName = "strStartDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "strEndDate" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 1965 Then
            If Args.ReportUIControlHashTableObject.ControlName = "dtFROMDateRange" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "dtToDateRange" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 298 Then
            If Args.ReportUIControlHashTableObject.ControlName = "dtmFrom" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "dtmTo" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 299 Then
            If Args.ReportUIControlHashTableObject.ControlName = "dtmFrom" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "dtmTo" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 302 Then
            If Args.ReportUIControlHashTableObject.ControlName = "dtmFrom" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "dtmTo" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        If Args.ReportUIControlHashTableObject.ReportID = 305 Then
            If Args.ReportUIControlHashTableObject.ControlName = "DTMFROM" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.AddMonths(-1))
            End If
            If Args.ReportUIControlHashTableObject.ControlName = "DTMTO" Then
                Args.ReplacementValue = CommonFunction.Dates.GetDate(Now.Date())
            End If
        End If
        MyBase.Before_PlotControl(Cancel, Args)
    End Sub

    Protected Overrides Sub After_PlotControl(ByVal Args As AdHocReports.UI.ReportUIControlArgs)
        'Fifth event to get fired for a control.
        'From this event Args.InsertAfterControl is used.
        'If Args.InsertAfterControl is not blank then it is written on response,
        'after plotting the ControlHtml within td having id='tdControl'.

        'Please comment the following code if you want to use this overriden method.
        MyBase.After_PlotControl(Args)
    End Sub

    Protected Overrides Sub After_PlotControlCell(ByVal Args As AdHocReports.UI.ReportUIControlArgs)
        'Sixth event to get fired for a control.
        'From this event Args.StringToBeInserted is used.
        'If Args.StringToBeInserted is not blank then it is written on response,
        'after plotting the closing tag of td having id='tdControl'.

        'Please comment the following code if you want to use this overriden method.
        MyBase.After_PlotControlCell(Args)
    End Sub

#End Region

#Region "Events for Menu"

    Protected Overrides Sub Menu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Menu)
        'To Initialize the menu. You can override if you want. But not needed in most of the cases.
        MyBase.Menu_Initialize(Cancel, Args)


    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links)
        ' If you want to customize the menu or cancel a link yo can do it here.
        'e.g. 
        ''If Args.LinkName = "EXCEL" AndAlso MyBase.m_lngReportID = 786 Then
        ''    Cancel = True
        ''End If
    End Sub

#End Region

#Region "Combo Related Code"

    Protected Overrides Function InitReportUI() As AdHocReports.UI.ReportUI
        'Necessary only if you want to populate the dropdown using your own logic.

        Return New My_ReportUI
    End Function
#Region "Class ReportUI"
    Private Class My_ReportUI
        Inherits AdHocReports.UI.ReportUI
        'All the code is moved to AdHocReports.UI.ReportUI class in Whiz.Reports.Common.dll

        Protected Overrides Function GetComboSQL(ByVal objReportUIHashTable As AdHocReports.UI.cReportUI, ByVal QueryID As Long, ByRef strMatchField As String) As String
            ' If you want to populate the combo used for input according to your logic,
            ' then comment the following code and return the SQL [String] which will fetch the desired result set.

            'Developer can make use of following Protected functions:

            '1) MyBase.CheckDependency(objReportUIHashTable.ReportID, objReportUIHashTable.ReportUIControlID, Me.UseMSSQL)
            ' This function checks whether there exist any dependent control on this control.


            '2) MyBase.CheckIfDependent(objReportUIHashTable.MasterTableID,Me.UseMSSQL)
            ' This function checks whether this control is dependant on other control within report or not.

            '3) MyBase.CheckIfDependentOnTable
            'Dim strRelativeKey As String = ""
            'Dim lngMasterTableIDFromRequest As String = CLng(CheckIsNothing( HttpContext.Current.Request.QueryString("MasterTableID"),"0"))
            'MyBase.CheckIfDependentOnTable(objReportUIHashTable.MasterTableID, lngMasterTableIDFromRequest, strRelativeKey, Me.UseMSSQL)
            ' This function checks whether this control is dependant on the control, whose onChange just occured.

            'e.g.
            'If objReportUIHashTable.ReportID = 786 AndAlso objReportUIHashTable.ControlName = "strUserName" Then
            '    Return "usp_sel_tbl_PM_Employee_UserNames"
            'Else
            '    Return MyBase.GetComboSQL(objReportUIHashTable, QueryID, strMatchField)
            'End If
            If objReportUIHashTable.ReportID = 2525 Then
                If objReportUIHashTable.ControlName = "intReportingEmployeeID" Then
                    Return "usp_Sel_ReportingManagerList " + HttpContext.Current.Session("intUserID").ToString
                Else
                    Return MyBase.GetComboSQL(objReportUIHashTable, QueryID, strMatchField)
                End If
            End If
            'Added By Amol Changle On: 04 Dec 2008
            'Purpose: To select Project Reportees of loggen in user
            If objReportUIHashTable.ReportID = 2527 Then
                If objReportUIHashTable.ControlName = "intReportingEmployeeID" Then
                    Return "Usp_Sel_ProjetReportees_List " + HttpContext.Current.Session("intUserID").ToString
                Else
                    Return MyBase.GetComboSQL(objReportUIHashTable, QueryID, strMatchField)
                End If
            End If
            'End Addition
            Return MyBase.GetComboSQL(objReportUIHashTable, QueryID, strMatchField)
        End Function

    End Class
#End Region

#End Region

#Region "HEader Footer related code"
    Protected Overridable Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)
        'This method will be available for header/footer being plotted on ReportUI.
        MyBase.Before_Header_Footer_Print(Cancel, Args)
    End Sub
#End Region

End Class