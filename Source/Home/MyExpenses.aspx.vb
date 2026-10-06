Public Partial Class MyExpenses
    Inherits WebPages.Template.WhizTemplate
    Protected sbHtml As New System.Text.StringBuilder
    Protected strSQL As String = ""
    Protected drNodeaccess As IDataReader
    Protected blnAdd As Boolean = False
    Protected blnEdit As Boolean = False
    Protected blnDelete As Boolean = False
    Protected blnView As Boolean = False
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected Shared m_strTagID As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        GetGlobalObject()
    End Sub

    Public Sub PageInit()
        DrawPage()
    End Sub
    Public Sub DrawPage()
        sbHtml.Append("<div ID='PageDiv' height='100%' style='overflow:auto;width:99.9%;'>")
        sbHtml.Append("<table CELLPADDING='0' CELLSPACING='0' BORDER='0' Width='100%' height='100%' style='padding:0px 0px 0px 0px;' >")
        sbHtml.Append("<TR>")
        sbHtml.Append("<TD vAlign=top style='padding:0px 0px 0px 0px; align='left'>")
        sbHtml.Append("<UL class='tabview' align='left' >")

        If GetTagAccessRights(3556) = True Then
            sbHtml.Append("<LI class='clsTREven'><a id='li_MyExpenses' name='li_MyExpenses' href='javascript:TabOnClick(0)' onmouseover='javascript:ShowSubTag(0)' >Expense Entry</a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Leaves'>
            'onmouseover='javascript:TabOnClick(4)'
        End If

        If GetTagAccessRights(3593) = True Then
            sbHtml.Append("<LI class='clsTREven'><a id='li_MyExpenses' name='li_MyExpenses' href='javascript:TabOnClick(1)' onmouseover='javascript:ShowSubTag(1)' >My Expense Sheet</a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Profile'>
            'onmouseover='javascript:TabOnClick(0)'
        End If
        If GetTagAccessRights(3595) = True Then
            sbHtml.Append("<LI class='clsTREven'><a id='li_MyExpenses' name='li_MyExpenses' href='javascript:TabOnClick(2)' onmouseover='javascript:ShowSubTag(2)' >Expense Sheet Approval</a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Home'>
            'onmouseover='javascript:TabOnClick(1)'
        End If
        If GetTagAccessRights(3596) = True Then
            sbHtml.Append("<LI class='clsTREven'><a id='li_MyExpenses' name='li_MyExpenses' href='javascript:TabOnClick(3)' onmouseover='javascript:ShowSubTag(3)' >Escalated Expense Sheets</a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Alerts'>
            'onmouseover='javascript:TabOnClick(2)'
        End If

        If GetTagAccessRights(3597) = True Then
            sbHtml.Append("<LI class='clsTREven'><a id='li_MyExpenses' name='li_MyExpenses' href='javascript:TabOnClick(4)' onmouseover='javascript:ShowSubTag(4)' >Finance Approval</a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Leaves'>
            'onmouseover='javascript:TabOnClick(3)'
        End If

        If GetTagAccessRights(3598) = True Then
            sbHtml.Append("<LI class='clsTREven'><a id='li_MyExpenses' name='li_MyExpenses' href='javascript:TabOnClick(5)' onmouseover='javascript:ShowSubTag(5)' >Expense Bifurcation</a></LI>") '<img src='../../Images/Home/Button1.gif' border=0 title='My Leaves'>
            'onmouseover='javascript:TabOnClick(4)'
        End If
        sbHtml.Append("</UL>")
        sbHtml.Append("</TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("<TR>")
        'sbHtml.Append("<TD ID='tdDot1' name='tdDot1' vAlign=top width=1px   background='../../Images/Home/dot2.gif' onclick='javascript:ShowTree()'><a name='aShowTree' id='aShowTree' style=""text-decoration:none;"" href='javascript:HideTree()' ><img ID='ImgShowHide' src='../../Images/ScrollLeft.gif' border=0 /></a></TD>")
        sbHtml.Append("<TD vAlign=top width='99.9%' height='99.9%' id='td_iframe' style='padding:0px 0px 0px 0px;BORDER: black 1px outset;'>")
        sbHtml.Append("<iframe name='frmMain' height='99.9%'  id='frmMain' onLoad='calcHeight()'  src='' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>") 'onmouseover='HideFrame()'
        sbHtml.Append("</TD>")
        sbHtml.Append("</TR></TABLE>")
        sbHtml.Append("</div>")

        CommonFunction.General.WriteHTML(sbHtml.ToString)
        sbHtml = Nothing
        drNodeaccess = Nothing
    End Sub
    Private Function GetTagAccessRights(ByVal lngTagID As Long, Optional ByVal IsModuleAccess As Boolean = False) As Boolean
        '=====================================================================
        ' Function  Name		:	GetTagAccessRights()
        ' Parameters Passed		:	TagID
        ' Returns				:	boolean value whether tag is accessable or not
        ' Parameters Affected	:	None
        ' Purpose				:	To verify whether tag is accessable or not
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        Dim m_objAccess As New WebPage.Templates.AccessRights

        Dim IsAccessForNode As Boolean


        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            m_objAccess.GetAccess(m_GlobalObject, IsModuleAccess)

            If IsModuleAccess Then
                Return m_objAccess.Access()
            End If

            If m_objAccess.Add = True OrElse m_objAccess.Delete = True OrElse m_objAccess.Edit = True OrElse m_objAccess.View Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        Return IsAccessForNode

    End Function

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()
    End Sub

End Class