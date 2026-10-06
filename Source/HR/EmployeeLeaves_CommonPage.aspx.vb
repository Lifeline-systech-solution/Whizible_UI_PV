Imports CommonEngines.General.cEventHandlers

Public Class EmployeeLeaves_CommonPage

    Inherits CommonPage
    ' Added BY NitinVS on 14 May 2007 for WhizibleSEM 7.0 
    ' Leave status is used at lot of placed hence getting the leave details on load which will be used in the events
    Dim LeaveStatusID As String = "0"


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
    Private m_objTemplate As WebPages.Template.WhizTemplate
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "EmployeeLeaves_CommonList.aspx"
        MyBase.strFormPage = "EmployeeLeaves_CommonPage.aspx"
        If Request.Params("FromXML") = "1" Then
            Response.Clear()
            Response.Write(GetLeaveTypes)
            Response.End()
            'Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
            'Purpose:To avoid leave duplication in edit mode
        ElseIf Request.Params("FromXML") = "2" Then
            Response.Clear()
            Response.Write(GetLeaveIDs)
            Response.End()
            'End of Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
        Else
            MyBase.Page_Load(sender, e)
        End If

    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

        If m_objGlobal.ParentTagID = 0 Then
            'Initialize the Resources
            'm_objTemplate.InitializeResources("AppResources.EmployeeLeaveApplication", "AppResources")
            MyBase.InitializeResources("AppResources.EmployeeLeaveApplication", "AppResources")
            Dim strScript As String

            'Added by VarunA on 11-May-2007 Cleanup Activity for leave workflow
            Dim strEmployeeID As String
            Dim dr As IDataReader
            'End by VarunA on 11-May-2007
            'Initialize the varibles used to display validation messages
            strScript = "var strDateMsg='" + MyBase.GetResourceString("LEAVE_APPLICATION_HALFDAY_MESSAGE") + "';" + vbCrLf
            strScript += "var objXHttp;" + vbCrLf
            strScript += "var blnFlag = false;" + vbCrLf

            strScript += "var strText = new String();" + vbCrLf
            strScript += "var arrStr = new Array();" + vbCrLf

            strScript += "	function HandlerOnReadyState()" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "if (objXHttp.readyState==4)" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "if (objXHttp.responseText != null) " + vbCrLf
            strScript += " {" + vbCrLf

            strScript += "strText = objXHttp.responseText;" + vbCrLf
            strScript += "arrStr = strText.split(""|"");" + vbCrLf

            strScript += " if (arrStr[0] == 'True')" + vbCrLf
            'Comment and modification done by SuchitraP on 25-Jun-2007 for IssueID 11887
            'strScript += " {alert('Employee has already applied for leave between \'' + objfrm.FromDate.value + '\' and \'' + objfrm.ToDate.value + '\'');" + vbCrLf
            strScript += " {alert('Employee has already applied for Leave/Work From Home between \'' + objfrm.FromDate.value + '\' and \'' + objfrm.ToDate.value + '\'');" + vbCrLf
            'End of Comment and modification done by SuchitraP on 25-Jun-2007 for IssueID 11887
            strScript += " blnFlag = true;" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += " else" + vbCrLf
            strScript += " blnFlag = false;" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf

            'Added by PrashantD on 16 March 2007 for IssueID 11099
            'Purpose: Writing AJAX methods 
            ''Added By Usha Pandit On 26.06.2019 For Leave Balance and Leave Type display issue On Chrome
            strScript += " 
    function WhichBrowser() {

	    var brwser = '';
	    var ua = navigator.userAgent, tem,
        M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
	    if (/trident/i.test(M[1])) {
	        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
	        //return 'IE '+(tem[1] || '');
	        return 'IE';
	    }
	    if (M[1] === 'Chrome') {
	        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
	        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
	        brwser = 'CR';
	    }
	    else if (M[1] === 'Firefox') {
	        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
	        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
	        brwser = 'FF';
	    }
	    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
	    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
	    //return M.join(' ');
	    return brwser;
	} " + vbCrLf
            ''Added By Usha Pandit On 26.06.2019 For Leave Balance and Leave Type display issue On Chrome
            strScript += "function loadXMLDoc(url,reqQuery){" + vbCrLf

            ''Added By Usha Pandit On 26.06.2019 For Leave Balance and Leave Type display issue On Chrome

            strScript += " var Browser = WhichBrowser(); "
            strScript += " if (Browser == 'IE') { "
            ''End Of Added By Usha Pandit On 26.06.2019 For Leave Balance and Leave Type display issue On Chrome

            strScript += " if(window.ActiveXObject || 'ActiveXObject' in window) {" + vbCrLf
            strScript += "xmlhttp=new ActiveXObject(""Microsoft.XMLHTTP"");" + vbCrLf
            strScript += "if (xmlhttp) {" + vbCrLf
            'Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
            strScript += "if (reqQuery==1){xmlhttp.onreadystatechange=ApproveState_Change;}else{" + vbCrLf
            'End of addition by SuchitraP on 8-Aug-2007 for IssueID 14637
            strScript += "xmlhttp.onreadystatechange=state_Change;" + vbCrLf
            'Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
            strScript += "}" + vbCrLf
            'End of addition by SuchitraP on 8-Aug-2007 for IssueID 14637
            strScript += "xmlhttp.open(""POST"",url,false);" + vbCrLf
            strScript += "xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');" + vbCrLf
            strScript += "xmlhttp.send(reqQuery)" + vbCrLf
            strScript += "}" + vbCrLf

            strScript += "else if (window.XMLHttpRequest) {" + vbCrLf
            strScript += "xmlhttp=new XMLHttpRequest();" + vbCrLf

            'Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
            strScript += "if (reqQuery==1){xmlhttp.onreadystatechange=ApproveState_Change;}else{" + vbCrLf
            'End of addition by SuchitraP on 8-Aug-2007 for IssueID 14637
            'Added By VarunA on 25-Sep-2008 IssueID-22541
            'Purpose : To have the leave type dropdown value in (Mozilla)
            strScript += "if (ns) {" + vbCrLf
            strScript += "xmlhttp.onreadystatechange=state_Change(); }" + vbCrLf
            strScript += "else {" + vbCrLf
            'End By VarunA on 25-Sep-2008 IssueID-22541
            strScript += "xmlhttp.onreadystatechange=state_Change; }" + vbCrLf
            'Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
            strScript += "}" + vbCrLf
            'End of addition by SuchitraP on 8-Aug-2007 for IssueID 14637
            strScript += "if(ns) {" + vbCrLf
            'Comment and Modification done by SuchitraP on 21-Nov-2007 for IssueID 16581
            'Purpose: The Leave Approver do not able to approve the leave in firefox
            'End of addition by SuchitraP on 8-Aug-2007 for IssueID 14637
            'Modified By VarunA on 25-Sep-2008 IssueID-22541
            'Purpose : To have the leave type dropdown value in (Mozilla)
            'strScript += "xmlhttp.open('GET',url+'?'+reqQuery,false);" + vbCrLf
            'strScript += "xmlhttp.open(""GET"",url+""&""+reqQuery,true);" + vbCrLf
            strScript += "xmlhttp.open('GET',url+'?'+reqQuery,false);" + vbCrLf
            'End By VarunA on 25-Sep-2008 IssueID-22541
            'strScript += "xmlhttp.send(false);" + vbCrLf
            strScript += "xmlhttp.send(null);" + vbCrLf
            'End of comment and modification by SuchitraP on 21-Nov-2007 for IssueID 16581
            'Added By VarunA on 25-Sep-2008 IssueID-22541
            'Purpose : To have the leave type dropdown value in (Mozilla)
            strScript += "if(xmlhttp.responseText != null) {" + vbCrLf
            strScript += "xmlDoc= document.implementation.createDocument("""","""",null);" + vbCrLf
            strScript += "xmlDoc.async=false;" + vbCrLf
            strScript += "xmlDoc.load(xmlhttp.responseXML);" + vbCrLf
            strScript += "state_Change(); }" + vbCrLf
            'End By VarunA on 25-Sep-2008 IssueID-22541
            strScript += "}" + vbCrLf
            strScript += "else {" + vbCrLf
            strScript += "xmlhttp.open(""POST"",url,false);" + vbCrLf
            strScript += "xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');" + vbCrLf
            strScript += "xmlhttp.send(reqQuery);" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf
            'strScript += "else if(window.ActiveXObject) {" + vbCrLf
            'strScript += "xmlhttp=new ActiveXObject(""Microsoft.XMLHTTP"");" + vbCrLf
            'strScript += "if (xmlhttp) {" + vbCrLf
            ''Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
            'strScript += "if (reqQuery==1){xmlhttp.onreadystatechange=ApproveState_Change;}else{" + vbCrLf
            ''End of addition by SuchitraP on 8-Aug-2007 for IssueID 14637
            'strScript += "xmlhttp.onreadystatechange=state_Change;" + vbCrLf
            ''Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
            'strScript += "}" + vbCrLf
            ''End of addition by SuchitraP on 8-Aug-2007 for IssueID 14637
            'strScript += "xmlhttp.open(""POST"",url,false);" + vbCrLf
            'strScript += "xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');" + vbCrLf
            'strScript += "xmlhttp.send(reqQuery)" + vbCrLf
            'strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf


            ''Added By Usha Pandit On 26.06.2019 For Leave Balance and Leave Type display issue On Chrome
            strScript += "} //browser " + vbCrLf
            strScript += " else {
            xmlhttp = new XMLHttpRequest();
            if (xmlhttp) {
                    if (reqQuery == 1) { xmlhttp.onreadystatechange = ApproveState_Change; } else {
                        xmlhttp.onreadystatechange = state_Change;
                    }
                    xmlhttp.open(""POST"", url, false);
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(reqQuery)
            }
             else if (window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                    if (reqQuery == 1) { xmlhttp.onreadystatechange = ApproveState_Change; } else {
                        if (ns) {
                            xmlhttp.onreadystatechange = state_Change();
                        }
                        else {
                            xmlhttp.onreadystatechange = state_Change;
                        }
                    }
                    if (ns) {
                        xmlhttp.open('GET', url + '?' + reqQuery, false);
                        xmlhttp.send(null);
                        if (xmlhttp.responseText != null) {
                            xmlDoc = document.implementation.createDocument("", "", null);
                            xmlDoc.async = false;
                            xmlDoc.load(xmlhttp.responseXML);
                            state_Change();
                        }
                    }
                    else {
                        xmlhttp.open(""POST"", url, false);
                        xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xmlhttp.send(reqQuery);
                    }
                }
        } " + vbCrLf

            ''End Of Added By Usha Pandit On 26.06.2019 For Leave Balance and Leave Type display issue On Chrome

            strScript += "}" + vbCrLf
            'Added By VarunA on 8-May-2007 Cleanup Activity for leave workflow
            strScript += "var arrObjBal=new Array();" + vbCrLf
            strScript += "var j=0;" + vbCrLf
            strScript += "var k=0;" + vbCrLf
            'End By VarunA on 8-May-2007
            'Added By VarunA on 6-June-2007 For Whizible Regression Project Issue-13394
            strScript += "var arrOptions;" + vbCrLf
            'End By VarunA on 6-June-2007
            strScript += "function state_Change() {"
            strScript += "var str='';" + vbCrLf
            strScript += "if (xmlhttp.readyState==4)" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "if (xmlhttp.status==200)" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "str = xmlhttp.responseText;" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf
            'Comment and Modified By VarunA on 6-June-2007 For Whizible Regression Project Issue-13394
            'strScript += "var arrOptions = str.split(""#-$"");" + vbCrLf
            strScript += "arrOptions = str.split(""#-$"");" + vbCrLf
            'End By By VarunA on 6-June-2007
            strScript += "var i=0;" + vbCrLf
            strScript += "var ctrl;" + vbCrLf
            strScript += "var objLeaveType=document.getElementById(""LeaveTypeID"");" + vbCrLf
            'Added By VarunA on 6-June-2007 For Whizible Regression Project Issue-13394
            strScript += "if(objLeaveType) {" + vbCrLf
            'End By VarunA on 6-June-2007
            strScript += "for(i=0;i<objLeaveType.options.length;i++)" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "objLeaveType.removeChild(objLeaveType.options[i]);" + vbCrLf
            strScript += "i=i-1;" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "ctrl = document.createElement(""OPTION"");" + vbCrLf
            strScript += "ctrl.value='';" + vbCrLf
            strScript += "objLeaveType.appendChild(ctrl);" + vbCrLf
            strScript += "ctrl.text='';" + vbCrLf
            'Added & Modified By VarunA on 6-June-2007 For Whizible Regression Project Issue-13394
            strScript += "if(arrOptions) {" + vbCrLf
            'strScript += "if(arrOptions.length>1) " + vbCrLf
            strScript += "if(arrOptions.length>1) {" + vbCrLf
            'End By VarunA on 6-June-2007
            strScript += "for(i=0;i<arrOptions.length;i=i+3)" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "ctrl = document.createElement(""OPTION"");" + vbCrLf
            strScript += "ctrl.value=arrOptions[i];" + vbCrLf
            strScript += "objLeaveType.appendChild(ctrl);" + vbCrLf
            strScript += "ctrl.text=arrOptions[i+1];" + vbCrLf
            strScript += "}" + vbCrLf
            'Added by VarunA on 8-May-2007 Cleanup Activity for leave workflow
            strScript += "for(j=0;j<arrOptions.length;j=j+3)" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "arrObjBal[k]=arrOptions[j];" + vbCrLf
            strScript += "arrObjBal[k+1]=arrOptions[j+2];" + vbCrLf
            strScript += "k=k+2;" + vbCrLf
            strScript += "}" + vbCrLf
            'End By VarunA on 8-May-2007
            'Added By VarunA on 6-June-2007 For Whizible Regression Project Issue-13394
            strScript += "} } }" + vbCrLf
            'End By VarunA on 6-June-2007
            strScript += "}" + vbCrLf
            'End of addition by PrashantD on 16 March 2007


            'Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
            strScript += "var arrLeaves;" + vbCrLf
            strScript += "var iterator;" + vbCrLf
            strScript += "function ApproveState_Change() {"

            strScript += "var str='';" + vbCrLf
            strScript += "var showDates='';" + vbCrLf
            strScript += "var strDates='';" + vbCrLf

            strScript += "if (xmlhttp.readyState==4)" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "if (xmlhttp.status==200)" + vbCrLf
            strScript += "{" + vbCrLf

            strScript += "var str=xmlhttp.responseText;" + vbCrLf

            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "if(str!=null && str!=''){" + vbCrLf
            strScript += "arrLeaves=str.split(""|"");" + vbCrLf
            strScript += "if(arrLeaves[0]==1){" + vbCrLf
            strScript += "window.open ('../HR/HR_AddComments.aspx?Mode=Approve&LeaveID=' + arrLeaves[1],'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 250)/2 + ',width=600,height=250');" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "if(arrLeaves[0]==0){" + vbCrLf
            strScript += "for(iterator=1;iterator<arrLeaves.length;iterator=iterator+1){" + vbCrLf
            strScript += "strDates+=arrLeaves[iterator]+','" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "showDates = replaceSubstring(strDates.substring(0,strDates.length-1),',',',\n');" + vbCrLf
            strScript += "alert('Leave has already been applied for \n'+showDates);" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf


            'End of addition by SuchitraP on 8-Aug-2007 for IssueID 14637



            'Added By VarunA on 11-May-2007 Clean Activity for leave workflow
            'Purpose : For edit mode to have the leave balance
            Dim i As Integer
            Dim strQuery As String = ""
            If strPrimaryKey <> "" Then
                i = 0
                dr = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_LeaveTypemaster NULL," & strPrimaryKey, MyBase.UseSQL)
                While dr.Read
                    strScript += "arrObjBal[" + i.ToString + "]=" + dr("LeaveTypeID").ToString + ";" + vbCrLf
                    strScript += "arrObjBal[" + (i + 1).ToString + "]=" + dr("LeaveBalance").ToString + ";" + vbCrLf
                    i = i + 2
                End While
                CommonFunctions.Data.DisposeDataReader(dr)
            End If
            'End By VarunA on 11-May-2007

            'Added By NitinVS on 14 May 2007 for WhizibleSEM 7.0 
            ' To get Leave status 
            If strPrimaryKey <> "" Then
                ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                ''strQuery = "SELECT LeaveStatusID FROM tbl_PM_EmployeeLeaveDetails WHERE LeaveID = " & strPrimaryKey
                strQuery = "usp_sel_tbl_PM_EmployeeLeaveDetails_LeaveStatusID " & strPrimaryKey
                ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                LeaveStatusID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
            End If

            PageUIPreRender = strScript
            'ReInitialize the Resources
            ' m_objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
            MyBase.InitializeResources("AppResources.EventHandlers", "AppResources")
            'Application standard return code
            strActionCode = ReturnCodes.ON_LOAD.ToString
        Else
        End If

    End Function



    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Modifed By NitinVS on 14 May 2007 for WhizbleSEM 7 
        ' Replaced the repeated database calls for Leave Status 

        If Args.SystemLinkType.Trim.ToUpper = "DELETE" Or Args.SystemLinkType.Trim.ToUpper = "SELECT_ALL" Then
            Cancel = True
        End If
        'Added By JayavantK on 15-Sep-2004
        'Hide the Save and 'Save and Add' menu links when the leave status is not submitted 
        If Args.SystemLinkType.Trim.ToUpper = "SAVE" Or Args.SystemLinkType.Trim.ToUpper = "SAVE_ADD" Then
            If Args.PrimaryKeyValue.Trim <> "" Then
                'Dim strQuery As String = ""
                'strQuery = "SELECT LeaveID FROM tbl_PM_EmployeeLeaveDetails WHERE LeaveStatusID = 1 AND LeaveID = " & Args.PrimaryKeyValue
                'If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") = "" Then
                'Added By Chakshuta H
                'If LeaveStatusID <> "1" Then
                '    Cancel = True
                'End If
                Cancel = True
                'Ended By Chakshuta H
            End If
        End If
        'End Addition
        '***** Code added by SandipL on 24 Nov 2005 
        'Purpose - server side validation whether Employee has already applied for leaves for these dates 
        If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
            'Commented And Added By Usha Pandit On 23.08.2020 For validation of already applied leaves for specific date range
            'Args.ToBeInsertedInFunction = " var strUrl; " + vbCrLf

            Args.ToBeInsertedInFunction = " var objFromDate = GetObjectReference('frmCommonPage', 'FromDate'); " + vbCrLf
            Args.ToBeInsertedInFunction += " var objToDate = GetObjectReference('frmCommonPage', 'ToDate'); " + vbCrLf
            Args.ToBeInsertedInFunction += " var objNonDatabase5 = GetObjectReference('frmCommonPage', 'NonDatabase5'); " + vbCrLf
            Args.ToBeInsertedInFunction += " var objEmployeeID = GetObjectReference('frmCommonPage', 'EmployeeID'); " + vbCrLf
            Args.ToBeInsertedInFunction += " var objFirstHalfDay = GetObjectReference('frmCommonPage', 'FirstHalfDay'); " + vbCrLf
            Args.ToBeInsertedInFunction += " var objSecondHalfDay = GetObjectReference('frmCommonPage', 'SecondHalfDay'); " + vbCrLf

            Args.ToBeInsertedInFunction += " var IsFirstHalfExists = false; " + vbCrLf
            Args.ToBeInsertedInFunction += " var IsSecondHalfExists = false; " + vbCrLf
            Args.ToBeInsertedInFunction += " var blnNoHalfDayChecked = false; " + vbCrLf
            Args.ToBeInsertedInFunction += " var dtFromdate = objFromDate.value; " + vbCrLf

            Args.ToBeInsertedInFunction += " var dtToDate = objToDate.value; " + vbCrLf
            Args.ToBeInsertedInFunction += " if (objFirstHalfDay.checked == false && objSecondHalfDay.checked == false) { " + vbCrLf
            Args.ToBeInsertedInFunction += " blnNoHalfDayChecked = true; " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf

            Args.ToBeInsertedInFunction += " if (objNonDatabase5 != null) " + vbCrLf
            Args.ToBeInsertedInFunction += " { " + vbCrLf
            Args.ToBeInsertedInFunction += "     for (i = 1;i<objNonDatabase5.length;i++) " + vbCrLf
            Args.ToBeInsertedInFunction += "     { " + vbCrLf
            Args.ToBeInsertedInFunction += "         var dtDates = objNonDatabase5[i].text; " + vbCrLf
            Args.ToBeInsertedInFunction += "         var arrDates = dtDates.toString().split('#'); " + vbCrLf
            Args.ToBeInsertedInFunction += "         var curEmployee = objNonDatabase5[i].value; " + vbCrLf
            Args.ToBeInsertedInFunction += "         var curFirstHalf = arrDates[2]; " + vbCrLf
            Args.ToBeInsertedInFunction += "         var curSecondHalf = arrDates[3]; " + vbCrLf
            Args.ToBeInsertedInFunction += "         var dtFrom = arrDates[0]; " + vbCrLf
            Args.ToBeInsertedInFunction += "         var dtTo = arrDates[1]; " + vbCrLf
            Args.ToBeInsertedInFunction += "         if (curEmployee == objEmployeeID.value) { " + vbCrLf

            Args.ToBeInsertedInFunction += " if (curFirstHalf == 0 && curSecondHalf == 0) { " + vbCrLf
            Args.ToBeInsertedInFunction += " IsFirstHalfExists = true; " + vbCrLf
            Args.ToBeInsertedInFunction += " IsSecondHalfExists = true; " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf
            Args.ToBeInsertedInFunction += " if (curFirstHalf == 1) { " + vbCrLf
            Args.ToBeInsertedInFunction += " IsFirstHalfExists = true; " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf
            Args.ToBeInsertedInFunction += " if (curSecondHalf == 1) { " + vbCrLf
            Args.ToBeInsertedInFunction += " IsSecondHalfExists = true; " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf



            Args.ToBeInsertedInFunction += " if ((Date.parse(dtFromdate.toString().replace(/-/g, ' ')) >= Date.parse(dtFrom.toString().replace(/-/g, ' ')) " + vbCrLf
            Args.ToBeInsertedInFunction += " && Date.parse(dtFromdate.toString().replace(/-/g, ' ')) <= Date.parse(dtTo.toString().replace(/-/g, ' '))) " + vbCrLf
            Args.ToBeInsertedInFunction += " || (Date.parse(dtToDate.toString().replace(/-/g, ' ')) >= Date.parse(dtFrom.toString().replace(/-/g, ' ')) " + vbCrLf
            Args.ToBeInsertedInFunction += " && Date.parse(dtToDate.toString().replace(/-/g, ' ')) <= Date.parse(dtTo.toString().replace(/-/g, ' '))) " + vbCrLf
            Args.ToBeInsertedInFunction += " || (Date.parse(dtFromdate.toString().replace(/-/g, ' ')) < Date.parse(dtFrom.toString().replace(/-/g, ' ')) " + vbCrLf
            Args.ToBeInsertedInFunction += " && Date.parse(dtToDate.toString().replace(/-/g, ' ')) > Date.parse(dtTo.toString().replace(/-/g, ' '))) " + vbCrLf
            Args.ToBeInsertedInFunction += " || (Date.parse(dtFromdate.toString().replace(/-/g, ' ')) <= Date.parse(dtFrom.toString().replace(/-/g, ' ')) " + vbCrLf
            Args.ToBeInsertedInFunction += " && Date.parse(dtToDate.toString().replace(/-/g, ' ')) > Date.parse(dtFrom.toString().replace(/-/g, ' ')))) " + vbCrLf

            Args.ToBeInsertedInFunction += " { " + vbCrLf
            Args.ToBeInsertedInFunction += " if ((IsFirstHalfExists == true && IsSecondHalfExists == true) || (curFirstHalf == 1 && objFirstHalfDay.checked == true) || (curSecondHalf == 1 && objSecondHalfDay.checked == true) " + vbCrLf
            Args.ToBeInsertedInFunction += " || ((curFirstHalf == 1 && blnNoHalfDayChecked == true) || (curSecondHalf == 1 && blnNoHalfDayChecked == true))) { " + vbCrLf

            Args.ToBeInsertedInFunction += " alert('Leave is already applied for the given Date Range!!!'); " + vbCrLf
            Args.ToBeInsertedInFunction += " return false; " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf
            Args.ToBeInsertedInFunction += " else { " + vbCrLf
            Args.ToBeInsertedInFunction += " if (IsFirstHalfExists == true && IsSecondHalfExists == true) { " + vbCrLf
            Args.ToBeInsertedInFunction += " IsFirstHalfExists = false; " + vbCrLf
            Args.ToBeInsertedInFunction += " IsSecondHalfExists = false; " + vbCrLf

            Args.ToBeInsertedInFunction += " } " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf
            Args.ToBeInsertedInFunction += " } " + vbCrLf

            Args.ToBeInsertedInFunction += " var strUrl; " + vbCrLf

            'End Of Added By Usha Pandit On 23.08.2020 For validation of already applied leaves for specific date range

            Args.ToBeInsertedInFunction += " strUrl = new String();" + vbCrLf
            Args.ToBeInsertedInFunction += " " + vbCrLf
            ' Code added by SwapnilR on 10 Oct 2006
            ' Purpose : Added new query string parameter AppliedUser which is select employee in the combo box
            ' w.r.t. IssueID #7075 SP8


            'Modified By VarunA on 23-Apr-2007 Issue-12820 Whizible Regression Project
            'Purpose : The value of AppliedUser was not passing correct
            ''Modified by Amit Mahadik on 30- May 2011 whizible sem 10.0
            Args.ToBeInsertedInFunction += " strUrl = '../General/XMLHttp.aspx?TagID=1209&EmployeeID=" & WhizGlobal.UserID & "&LeaveID=" & Args.PrimaryKeyValue & "&FromDate='+ objfrm.FromDate.value + '&ToDate=' + objfrm.ToDate.value + '&AppliedUser=' + GetObjectReference(""frmCommonPage"",""EmployeeID"").value + '&FirstHalfDay=' + objfrm.FirstHalfDay.checked + '&SecondHalfDay=' + objfrm.SecondHalfDay.checked;" + vbCrLf
            ''End Modified by Amit Mahadik on 30- May 2011 whizible sem 10.0
            'Args.ToBeInsertedInFunction += " strUrl = '../General/XMLHttp.aspx?TagID=1209&EmployeeID=" & WhizGlobal.UserID & "&LeaveID=" & Args.PrimaryKeyValue & "&FromDate='+ objfrm.FromDate.value + '&ToDate=' + objfrm.ToDate.value + '&AppliedUser=" + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("EmployeeID"), "0"), String) + "' ;" + vbCrLf
            'End By VarunA on 23-Apr-2007


            ' End of code addition by SwapnilR on 10th Oct 2006
            Args.ToBeInsertedInFunction += "if (document.all) " + vbCrLf
            Args.ToBeInsertedInFunction += " { " + vbCrLf
            Args.ToBeInsertedInFunction += " objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  " + vbCrLf
            Args.ToBeInsertedInFunction += " objXHttp.onreadystatechange = HandlerOnReadyState; " + vbCrLf
            Args.ToBeInsertedInFunction += " objXHttp.open('GET',strUrl, false); " + vbCrLf
            Args.ToBeInsertedInFunction += " objXHttp.send();           " + vbCrLf
            Args.ToBeInsertedInFunction += " 	}  " + vbCrLf
            Args.ToBeInsertedInFunction += "  	else  {" + vbCrLf
            Args.ToBeInsertedInFunction += " objXHttp = new XMLHttpRequest();  " + vbCrLf
            Args.ToBeInsertedInFunction += " objXHttp.onreadystatechange = HandlerOnReadyState(); " + vbCrLf
            Args.ToBeInsertedInFunction += "  objXHttp.open('GET',strUrl, false);" + vbCrLf
            Args.ToBeInsertedInFunction += " objXHttp.send(null);  }" + vbCrLf
            Args.ToBeInsertedInFunction += "if (blnFlag == true) " + vbCrLf
            Args.ToBeInsertedInFunction += " return;" + vbCrLf
        End If
        '***** End addition by SandipL on 24 Nov 2005
        'Modified BY NitinVS on 14 May 2007 for WhizibleSEM 7.0
        ' Added the if condition for LinkName = Approve or Reject 
        ''Added by Manishk on 27th Feb 2006 for SP 6 IssueID 2466
        If (Args.ClientSideFunctionName.ToUpper = "REJECT_ONCLICK") Or (Args.ClientSideFunctionName.ToUpper = "APPROVE_ONCLICK") Then

            'Dim lngLeaveStatusID As String = ""

            If Args.PrimaryKeyValue.Trim <> "" Then
                'Dim strQuery As String = ""
                'strQuery = "SELECT LeaveStatusID FROM tbl_PM_EmployeeLeaveDetails WHERE LeaveID = " & Args.PrimaryKeyValue
                'lngLeaveStatusID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                If (Args.ClientSideFunctionName.ToUpper = "APPROVE_ONCLICK") Then
                    If LeaveStatusID = "1" Or LeaveStatusID = "3" Then

                    Else
                        Cancel = True
                    End If
                ElseIf (Args.ClientSideFunctionName.ToUpper = "REJECT_ONCLICK") Then
                    If Trim(LeaveStatusID) = "3" Or Trim(LeaveStatusID) = "4" Then
                        Cancel = True
                    End If
                End If
            End If
            ''End of Added by Manishk on 27th Feb 2006 for SP 6 IssueID 2466
        End If

        'Commented By VarunA on 25-Sep-2008 IssueID-22541
        'Purpose : Approve link doen't work (Mozilla)
        'Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
        'Purpose:To avoid leave duplication in edit mode
        'If Args.ClientSideFunctionName.ToUpper = "APPROVE_ONCLICK" Then
        '    Args.ToBeInsertedInFunction = "var strForApprove,url;" + vbCrLf
        '    Args.ToBeInsertedInFunction = "strForApprove='1';" + vbCrLf
        '    Args.ToBeInsertedInFunction += " url = new String();" + vbCrLf
        '    Args.ToBeInsertedInFunction += " " + vbCrLf
        '    Args.ToBeInsertedInFunction += "url='../HR/EmployeeLeaves_CommonPage.aspx?TagID=1209&FromXML=2&LeaveID=' + lngUniqueID ;" + vbCrLf
        '    Args.ToBeInsertedInFunction += "loadXMLDoc(url,strForApprove);return;" + vbCrLf
        'End If
        'End of Addition done by SuchitraP on 8-Aug-2007 for IssueID 14637
        'End By VarunA on 25-Sep-2008 IssueID-22541
    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cEmployeeLeavesPlotControls(MyBase.m_objGlobal)
    End Function

    'Addition done by SuchitraP on 8-Aug-2007
    Private Function GetLeaveIDs() As String
        '=====================================================================
        ' Procedure Name		:	GetLeaveID
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To return LeaveID or Leave dates to AJAX response.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SuchitraP
        ' Created				:	8 Aug 2007
        ' Revisions				:	
        '=====================================================================
        Dim strLeaveID As String
        Dim sql As String
        Dim sbHtml As System.Text.StringBuilder = New System.Text.StringBuilder
        Dim strHtml, str As String
        Dim dr As IDataReader
        Dim count As Integer
        count = 0
        strLeaveID = HttpContext.Current.Request.Params("LeaveID")
        If strLeaveID <> "" Then
            sql = "EXEC usp_Sel_EmployeeLeaveDetails_Rejected " + strLeaveID
            'strHtml = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(sql, True), ""), ""), String)
            dr = CommonFunction.Data.GetDataReader(sql, True)
            While dr.Read
                If count = 0 Then
                    sbHtml.Append("0|")
                End If
                sbHtml.Append(dr("LeaveDate").ToString)
                sbHtml.Append("|")
                count += 1
            End While
        End If

        strHtml = sbHtml.ToString

        'strHtml = strHtml.Substring(0, sbHtml.Length - 1)
        CommonFunction.Data.DisposeDataReader(dr)


        If Not strHtml = "" Then
            strHtml = strHtml.Substring(0, sbHtml.Length - 1)
            Return strHtml
        Else
            sbHtml.Append("1|")
            sbHtml.Append(strLeaveID)
            str = sbHtml.ToString
            sbHtml = Nothing
            Return str
        End If

    End Function
    'End of addition by SuchitraP on 8-Aug-2007

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

        'added by HarshK on 08 Mar 2006
        Dim strLeaveID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("LeaveID_PK"), "0")
        'Added By VidyaJ - issueID - 11166
        strLeaveID = Gen.PrimaryKeyValue
        If strLeaveID = "" Then
            strLeaveID = "0"
        End If
        If strLeaveID <> "" Then
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            ''Dim strLeaveStatus As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select Leavestatus from d_tbl_PM_EmployeeLeaveDetails WHERE LeaveID=" & strLeaveID, MyBase.UseSQL), ""))
            Dim strLeaveStatus As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_d_tbl_PM_EmployeeLeaveDetails_Leavestatus " & strLeaveID, MyBase.UseSQL), ""))
            ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            strLeaveStatus = CommonFunctions.General.CheckIsNothing(strLeaveStatus, "")

            If strLeaveStatus.Trim <> "" Then
                Args.RightPageCaption = " Status : " & strLeaveStatus
            End If

        End If

        'End 'added by HarshK on 08 Mar 2006
    End Sub
    Private Function GetLeaveTypes() As String
        '=====================================================================
        ' Procedure Name		:	GetLeaveTypes
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To return LeaveTypeID,LeaveType as a string with "#-$" separator to AJAX response.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	PrashantD
        ' Created				:	16 March 2007
        ' Revisions				:	
        '=====================================================================
        Dim strEmployeeID As String
        Dim dr As IDataReader
        Dim sbHtml As System.Text.StringBuilder = New System.Text.StringBuilder
        Dim strHtml As String
        strEmployeeID = Request.Params("EmployeeID")
        If strEmployeeID <> "" Then
            dr = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_LeaveTypemaster " & strEmployeeID, MyBase.UseSQL)
            While dr.Read
                sbHtml.Append(dr("LeaveTypeID").ToString)
                sbHtml.Append("#-$")
                sbHtml.Append(dr("LeaveType").ToString)
                sbHtml.Append("#-$")
                'Added By VarunA on 8-May-2007 For Clean activity of leave workflow
                sbHtml.Append(dr("LeaveBalance").ToString)
                sbHtml.Append("#-$")
                'End By VarunA on 8-May-2007
            End While
            strHtml = sbHtml.ToString
            If strHtml.Length - 3 > 0 Then
                strHtml = strHtml.Substring(0, strHtml.Length - 3)
            End If

            CommonFunction.Data.DisposeDataReader(dr)

            Return strHtml
        End If
    End Function

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        'Added By VarunA on 11-May-2007 Clean Activity for Leave Workflow
        'Purpose : For handling email popup
        Dim strQuery As String = ""
        Dim drEmail As IDataReader
        Dim blnSendMail As Boolean = False
        Dim blnShowPopup As Boolean = False
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim intLeaveID As Integer = 0

        strQuery = "usp_Sel_tbl_PM_EmailMessages 481"
        drEmail = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)

        If PrimaryKey.Trim() <> "" Then
            Dim strScript As String
            strScript = "<script language = javascript>"
            If blnSendMail = True Then
                If blnShowPopup = True Then
                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LeaveOrWFH"), "") = "W" Then
                        strScript += "window.open('../General/SendEmail.aspx?MessageID=481&Type=W&LeaveID=" & PrimaryKey & "',null,'status=no,toolbar=no,menubar=no,location=no,width=600,height=500" + " left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 " + ");"
                    Else
                        strScript += "window.open('../General/SendEmail.aspx?MessageID=481&Type=L&LeaveID=" & PrimaryKey & "',null,'status=no,toolbar=no,menubar=no,location=no,width=600,height=500" + " left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 " + ");"
                    End If
                Else
                    intLeaveID = Convert.ToInt32(PrimaryKey)
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_481(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intLeaveID)
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If

            'If IsEditMode = False Then
            '    strScript += "window.location.href = 'EmployeeLeaves_CommonList.aspx?FromWhere=RM&MasterTagId=1209';"
            'End If



            strScript += "</script>"

            'Added by SuchitraP on 4-JUN-2007 for IssueID 13562
            'Purpose:SaveandAdd link used to perform only save operation and not add.
            Response.Write(strScript)
            AfterSave = ""
            strActionCode = ReturnCodes.DO_NOTHING.ToString
            RedirectToCL = False
            'End of addition by SuchitraP on 4-JUN-2007 for IssueID 13562

            'Commented by SuchitraP on 4-JUN-2007 

            'CommonFunction.General.WriteHTML(strScript)
            'MyBase.AfterSave(Global, ControlsHashTable, PrimaryKey, strActionCode, True, False)
            'End of Comment by SuchitraP on 4-JUN-2007 

        End If

        'End By VarunA on 11-May-2007
    End Function

    Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        'Addition done by SuchitraP on 28-MAY-2007 for IssueID 13393
        'Purpose:To show explaination of Legend
        Args.Legend = "Mandatory"
        'End of addition by SuchitraP on 28-MAY-2007 for IssueID 13393
    End Sub
End Class

Public Class cEmployeeLeavesPlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    'Added By VarunA on 12-Sep-2007 Whizible 7.1 Development & Release
    'Purpose : To check the access for an control which is a nondatabase (LeaveBalance) at the time of View Mode
    Private m_objViewOnlyAccessChk As WebPage.Templates.AccessRights
    'End By VarunA on 12-Sep-2007

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)

        'Get the Access Rights 
        'Added By VarunA on 12-Sep-2007 Whizible 7.1 Development & Release
        'Purpose : To check the access for an control which is a nondatabase (LeaveBalance) at the time of View Mode
        m_objViewOnlyAccessChk = New WebPage.Templates.AccessRights
        m_objViewOnlyAccessChk.GetAccess(WhizGlobal)
        'End By VarunA on 12-Sep-2007
    End Sub


    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If WhizGlobal.ParentTagID = 0 Then
            'Added By Usha Pandit On 19.08.2020 For validation of already applied leaves for specific date range
            If Args.ControlName.ToUpper = "NONDATABASE5" Then
                Args.AdditionalInformation = "usp_Get_ReportingEmployeeLeaveDates " & HttpContext.Current.Session("intUserID")
            End If
            'End Of Added By Usha Pandit On 19.08.2020 For validation of already applied leaves for specific date range
            'If Status is not Submitted in Edit mode
            If Args.IsEditMode = True And Args.PrimaryKeyValue <> "" Then
                ''Commented and Added By SuvarnaA on 30-Sep-2009 for ICRA RequestID - 23142
                ''Purpose: To resolve the issue related to the access for role having no access to the page.
                'If CType(CommonFunction.Data.CheckIsDBNull(drControls("LeaveStatusID"), "0"), Long) <> 1 Then
                '    Args.Editable = False
                'End If
                If drControls.GetSchemaTable.Columns.Contains("LeaveStatusId") = True Then
                    If CType(CommonFunction.Data.CheckIsDBNull(drControls("LeaveStatusID"), "0"), Long) <> 1 Then
                        Args.Editable = False
                    End If
                End If
                ''End of Added By SuvarnaA on 30-Sep-2009 for ICRA RequestID - 23142
            End If

            'Added By VarunA on 12-Sep-2007 Whizible 7.1 Development & Release
            'Purpose : To check the access for an control which is a nondatabase (LeaveBalance) at the time of View Mode
            If Args.IsEditMode = True AndAlso Args.PrimaryKeyValue <> "" AndAlso Args.ControlName.ToUpper = "NONDATABASE4" Then
                If m_objViewOnlyAccessChk.Add = False AndAlso m_objViewOnlyAccessChk.Edit = False Then
                    'User Has view only access
                    Args.IgnoreActualValue = True
                    Dim strLeaveBalance As String = ""
                    Dim blnUseSQL As Boolean = True

                    If drControls("LeaveOrWFH").ToString = "L" Then
                        blnUseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
                        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                        ''strLeaveBalance = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT LeaveBalance FROM tbl_PM_EmployeeLeaveMaster WHERE EmployeeID=" & drControls("EmployeeID").ToString & " AND LeaveTypeID=" & drControls("LeaveTypeID").ToString, blnUseSQL), ""))
                        strLeaveBalance = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_EmployeeLeaveMaster_LeaveBalance " & drControls("EmployeeID").ToString & "," & drControls("LeaveTypeID").ToString, blnUseSQL), ""))
                        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                        Args.NewValue = strLeaveBalance
                    Else
                        Args.NewValue = "-"
                    End If
                End If
            End If
            'End By VarunA on 12-Sep-2007

            'Added By VarunA on 13-Sep-2007 Whizible 7.1 Development & Release
            'Purpose : To show HalfDay data at the time of View Mode
            If Args.IsEditMode = True AndAlso Args.PrimaryKeyValue <> "" AndAlso Args.ControlName.ToUpper = "HALFDAY" Then
                If m_objViewOnlyAccessChk.Add = False AndAlso m_objViewOnlyAccessChk.Edit = False Then
                    'User Has view only access
                    Args.IgnoreActualValue = True
                    Args.ControlTypeID = CommonFunctions.Constants.CONTROL_TYPE_TEXT_BOX
                    Dim intHalfDay As Integer
                    Dim blnUseSQL As Boolean = True

                    blnUseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
                    ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                    '' intHalfDay = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT HalfDay FROM tbl_PM_EmployeeLeaveDetails WHERE LeaveID=" & drControls("LeaveID").ToString, blnUseSQL), ""))
                    intHalfDay = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_EmployeeLeaveDetails_HalfDay" & drControls("LeaveID").ToString, blnUseSQL), ""))
                    ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                    If intHalfDay = 0 Then
                        Args.NewValue = "No"
                    Else
                        Args.NewValue = "Yes"
                    End If
                End If
            End If
            'End By VarunA on 13-Sep-2007


            'Added by PrashantSJ on 06 Nov 2006
            'Purpose: To Plot the value of NonDatabase2(EmployeeName) in edit mode
            If Args.ControlName.ToUpper = "NONDATABASE2" Then
                Args.Mandatory = True
                If Args.IsEditMode = True Then
                    ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                    ''Dim strEmployeeName As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM v_tbl_PM_EmployeeLeaveDetails Where LeaveID =" & Args.PrimaryKeyValue, True), ""), String)
                    Dim strEmployeeName As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_v_tbl_PM_EmployeeLeaveDetails_EmployeeName " & Args.PrimaryKeyValue, True), ""), String)
                    ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                    Args.IgnoreActualValue = True
                    Args.NewValue = strEmployeeName
                End If

                'Added By VidyaJ - issueID- 11323
                If Args.IsEditMode = True Then
                    Args.Editable = False
                End If

                'Addition done by SuchitraP on 28-MAY-2007 for IssueID 13399
                'Purpose:To make Employee Name text box non-editible.
                If HttpContext.Current.Request.QueryString("Mode") = "ADD_NEW" Then
                    Args.Editable = False
                End If
                'End of addition done by SuchitraP on 28-MAY-2007 for IssueID 13399

                'Added By VarunA on 27-Sep-2007 Whizible 7.1 Development & Release (HotFix 7.0.022) Issue-15503
                'Purpose : To have EmployeeName textbox in disable mode, in Adding or Editing Mode.
                If HttpContext.Current.Request.QueryString("SubOperation") = "ADD" Then
                    Args.Editable = False
                End If
                'End Of Added By VarunA on 27-Sep-2007


            End If
            'End of addition by PrashantSJ on 06 Nov 2006


            'Added By VarunA on 6-June-2007 For Whizible regression Project Issue-13394
            'Purpose : To have the employee leave Type
            If Args.ControlName.ToUpper = "LEAVETYPEID" Then
                Dim strEmployeeID As String = ""
                Dim strQuery As String = ""
                If Args.IsEditMode = True And Args.PrimaryKeyValue <> "" Then
                    strEmployeeID = drControls("EmployeeID").ToString
                End If

                If strEmployeeID <> "" Then
                    strQuery = "Exec usp_Sel_tbl_PM_LeaveTypemaster " & strEmployeeID
                    Args.AdditionalInformation = strQuery
                    Args.DropDownEditSQL = strQuery
                End If

                'Added By VarunA on 17-Sep-2007 Whizible 7.1 Development & Release
                'Purpose : To have leave type in View Mode.
                If Args.IsEditMode = True AndAlso Args.PrimaryKeyValue <> "" AndAlso Args.ControlName.ToUpper = "LEAVETYPEID" Then
                    If m_objViewOnlyAccessChk.Add = False AndAlso m_objViewOnlyAccessChk.Edit = False Then
                        'User Has view only access
                        Args.IgnoreActualValue = True
                        Dim strLeaveType As String = ""
                        Dim blnUseSQL As Boolean = True
                        Args.ControlTypeID = CommonFunctions.Constants.CONTROL_TYPE_TEXT_BOX

                        If drControls("LeaveOrWFH").ToString = "L" Then
                            blnUseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
                            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                            ''strLeaveType = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT LeaveType FROM tbl_PM_LeaveTypeMaster WHERE LeaveTypeID=" & drControls("LeaveTypeID").ToString, blnUseSQL), ""))
                            strLeaveType = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_LeaveTypeMaster_LeaveType " & drControls("LeaveTypeID").ToString, blnUseSQL), ""))
                            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                            Args.NewValue = strLeaveType
                        Else
                            Args.NewValue = "Leave type is not applicable. Work from home is selected."
                        End If
                    End If
                End If
                'End By VarunA on 17-Sep-2007

            End If
            'End By VarunA on 6-June-2007


            ' Added By JayavantK on 15-Sep-2004
            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "") <> "" Then
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName)).ToString <> "" Then
                    Args.IgnoreActualValue = True
                    Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName).ToString
                End If
                If Args.ControlName.ToUpper = "LEAVETYPEID" Then
                    Dim strEmployeeID As String = ""
                    Dim strQuery As String = ""

                    strEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "")


                    If strEmployeeID <> "" Then
                        strQuery = "Exec usp_Sel_tbl_PM_LeaveTypemaster " & strEmployeeID
                        Args.AdditionalInformation = strQuery
                    End If
                ElseIf Args.ControlName.ToUpper = "HALFDAY" Then
                    If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName), "") <> "" Then
                        Args.ToBeInserted = "Checked"
                    End If
                    ' Code added by SwapnilR on 10th Oct 2006
                    ' Purpose : To show address and telephone number default selected.
                    '           w.r.t. IssueID #7075
                ElseIf Args.ControlName.ToUpper = "ADDRESS" Then
                    If Args.IsEditMode = False Then
                        Dim strEmployeeID As String = ""
                        Dim strQuery As String = ""

                        strEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "")
                        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                        ''strQuery = "SELECT Address FROM tbl_PM_Employee WHERE EmployeeID = " + strEmployeeID
                        strQuery = "usp_sel_tbl_PM_Employee_Address " + strEmployeeID
                        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                        Args.IgnoreActualValue = True
                        Args.NewValue = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), ""))
                    End If
                ElseIf Args.ControlName.ToUpper = "TELEPHONE" Then
                    If Args.IsEditMode = False Then
                        Dim strEmployeeID As String = ""
                        Dim strQuery As String = ""

                        strEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "")
                        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                        ''strQuery = "SELECT Phone FROM tbl_PM_Employee WHERE EmployeeID = " + strEmployeeID
                        strQuery = "usp_sel_tbl_PM_Employee_Phone " + strEmployeeID
                        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                        Args.IgnoreActualValue = True
                        Args.NewValue = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), ""))
                    End If

                    ' End of code addition by SwapnilR on 10th Oct 2006
                End If
                ' Commented By NitinVs on 14 May 2007 for Whizble 7.0 
                'added by HarshK on 09 Mar 2006
                'Else

                'If Args.PrimaryKeyValue <> "" Then
                '    Dim strEmployeeID As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT EmployeeID FROM v_tbl_PM_EmployeeLeaveDetails Where LeaveID =" & Args.PrimaryKeyValue, True), ""))
                '    Dim strQuery As String = ""

                '    If strEmployeeID <> "" Then
                '        strQuery = "Exec usp_Sel_tbl_PM_LeaveTypemaster " & strEmployeeID
                '        Args.AdditionalInformation = strQuery
                '    End If
                'End If

                'End added by HarshK on 09 Mar 2006

                'End Commenting By NitinVS  on 14 May 2007 for Whizble 7.0 

            End If
            'End Addition
        Else
        End If
    End Sub


    'Added By VarunA on 12-Sep-2007 Whizible 7.1 Development & Release
    Protected Overrides Sub Finalize()
        m_objViewOnlyAccessChk = Nothing
        MyBase.Finalize()
    End Sub
    'Added By VarunA on 12-Sep-2007
End Class

