Public Class CLCPReferenceImpl
    Inherits CLCPEvents.CLCPTemplate

    Public Shared Shadows Sub PageListPreRender(ByRef WhizGlobal As WebPages.Template.IGlobal, _
                ByRef strActionCode As String, _
                ByRef strMasterPrimaryKey As String, _
                ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
                ByRef PageListPreRender As String)
        PageListPreRender = "alert('Hi');"
        System.Web.HttpContext.Current.Response.Write("<H4>Hey I am coming from routed event</H4>")
    End Sub
End Class
