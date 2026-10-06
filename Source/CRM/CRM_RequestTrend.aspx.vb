Public Class CRM_RequestTrend
    Inherits WebPage.Templates.WhizTemplate
#Region "Constants"
    Private Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"  ' graph location
    Private m_intGraphHeight As Integer = 600               ' graph Height    
    Private m_intGraphWidth As Integer = 800                 '  graph width
    Private m_intWeekNo As Integer
#End Region
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'm_intGraphHeight = 800
        'm_intGraphWidth = 800
        'GenerateReportGraph()
    End Sub
    Protected Sub GenerateReportGraph()
        '=====================================================================
        ' Procedure Name        : GenerateReport()	
        ' Purpose               : to Generate HelpDesk Trend Graph
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 5 Dec 2007
        ' Revisions             :
        '=====================================================================


        Dim objGraph As Graph.Graph

        Dim strSQL As String
        Dim strImageFileName As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowCaptions As Boolean = True
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(4) As String
        Dim arrLegandcolor() As String = {"", "Red", "Yellow", "Green"}

        ' strSQL = "  EXEC  usp_Sel_ResourceUtilizationDetails_Monthly NULL,NULL,NULL,NULL,10,0,61,'268,306,309,312,322,326,354,361,376,391,393,417,422,423,424,443,446,447,453,454,455,456,457,458,464,465,467,468,469,471,479,480,481,482,483,488,491,496,499,505,507,508,509,510,511,512,513,514,515,516,518,519,521,522,523,526,527,528,531,532,533,534,535,536,538,539,540,545,546,548,550,551,552,554,557,559,560,561,562,563,564,565,566,568,570,571,572,573,574,578,579,580,581,582,583,584,585,586,587,588,592,596,597,599,600,666,667,670,672,680,694,698,703,713,720,735,736,737,738,747,748,750,751,753,754,755,756,757,763,765,766,767,768,770,771,772,774,781,782,790,791,793,796,799,808,815,826,831,845,851,853,862,864,866,879,881,894,915,946,961,999,1002,1008,1011,1031,1033,1039,1040,1042,1045,1052,1096,1099,1105,1108,1113,1114,1115,1116,1122,1123,1129,1144,1145,1148,1149,1150,1151,1155,1156,1158,1159,1163,1164,1165,1166,1167,1169,1170,1172,1173,1174,1175,1176,1177,1178,1180,1183,1185,1186,1190,1191,1192,1193,1195,1196,1197,1198,1199,1200,1201,1203,1204,1205,1206,1207,1209,1210,1214,1216,1217,1218,1219,1220,1221,1222,1225,1229,1230,1231,1232,1233,1234,1235,1237,1240,1242,1243,1244,1246,1248,1249,1250,1256,1257,1258,1259,1260,1261,1262,1263,1264,1265,1266,1267,1269,1270,1271,1272,1273,1274,1276,1277,1278,1279,1280,1283,1284,1285,1286,1288,1291,1292,1293,1294,1296,1307,1308,1311,1312,1314,1315,1316,1317,1318,1321,1323,1326,1327,1329,1331,1332,1333,1334,1335,1336,1337,1338,1339,1340,1343,1344,1346,1348,1349,1350,1351,1352,1353,1354,1355,1356,1357,1358,1359,1360,1362,1363,1365,1366,1367,1368,1369,1371,1372,1375,1376,1377,1380,1381,1382,1383,1386,1387,1389,1390,1391,1393,1394,1395,1396,1397,1398,1399,1400,1401,1402,1403,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1415,1416,1417,1418,1419,1420,1421,1422,1424,1425,1426,1427,1428,1429,1430,1432,1434,1435,1436,1439,1440,1441,1442,1443,1444,1445,1446,1447,1448,1449,1450,1451,1452,1453,1455,1456,1457,1458,1459,1460,1461,1462,1463,1464,1465,1466,1468,1469,1471,1472,1473,1474,1475,1476,1485,1486,1487,1488,1489,1490,1491,1492,1493,1495,1497,1498,1499,1500,1502,1503,1504,1508,1509,1510,1511,1512,1513,1517,1518,1519,1520,1521,1522,1523,1524,1525,1526,1529,1530,1531,1533,1534,1535,1540,1541,1542,1543,1544,1545,1547,1548,1550,1551,1552,1553,1554,1555,1556,1557,1558,1560,1572,1573,1577,1578,1579,1581,1585,1586,1587,1588,1589,1590,1591,1592,1593,1594,1596,1597,1598,1599,1601,1603,1604,1605,1606,1607,1608,1609,1611,1612,1614,1615,1620,1621,1622,1623,1624,1625,1626,1627,1628,1635,1636,1638,1640,1642,1644,1645,1646,1647,1648,1649,1650,1656,1658,1659,1660,1664,1677,1678,1679,1688,1690,1693,1694,1695,1710,1711,1712,1713,1714,1715,1716,1717,1721,1722,1723,1724,1725,1726,1727,1728,1729,1620,1532,1170,1629,1630,1633,268,1671,1672,1649,1653,1679', 0 "

        strImageFileName = "Request" + CommonFunction.FileDirectory.GetUniqueFileName()
        blnShowLegends = True
        strNomenclature = "ResourceUtilization"
        blnShowCaptions = True

        ' create the graph for the item values
        objGraph = New Graph.Graph
        Try
            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString
                .VirtualImagePath = ""
                .Enable3D = False
                arr(0) = "LINE"
                arr(1) = "LINE"
                arr(2) = "LINE"
                arr(3) = "LINE"
                'arr(4) = "LINE"
                'arr(5) = "LINE"
                .ChartType = arr
                .GraphTitleColor = "black"
                .ChartBackColor = "PaleGoldenRod"
                .ChartAreaColor = "GoldenRod"
                .ShowLegends = True
                .XAxisTitle = "Days"
                .Nomenclature = "No. Of Requests"
                .LegendDocking = "bottom"
                '.LegendStyle = "column"
                .LegendCaptionColor = "black"
                .PalleteStyle = "EARTHTONES"
                .EnableXAxis = True
                .EnableYAxis = True
                .EnableSmartLabels = False
                .ShowCaptions = False
                .GraphTitleColor = "Black"
                .ShowDataColumnNameAsXAxisTitle = False
                '.TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)

                '-- Fixed Settings
                .GraphTitle = "Status of Requests"
                '.TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
                .SQL = "EXEC USp_SEL_Requests " + m_intWeekNo.ToString
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .TitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"
                .LegendDocking = "BOTTOM"
                .LegendStyle = "ROW"
                .ChartAreaWidth = 95
                .ChartAreaHeight = 75
                ' return the graph image
                '.XAxisInterval = 1
                .LegendColor = arrLegandcolor
                .GenerateImage()
            End With


            '-- Display Graph
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY) & strImageFileName & ".png") Then
                Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
            Else
                Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
            End If

        Catch EX As Exception

        End Try
    End Sub
    Protected Sub DisplayPageDetails()
        Dim strMenu As String
        Dim arrMenu() As String = {"Previous Week", "Next Week", "Close", "?"}
        Dim arrMenuToolTip() As String = {"Previous Week", "Next Week", "Close", "Help"}
        Dim arrCSFunction() As String = {"Prev_OnClick()", "Next_OnClick()", "Close_OnClick()", "Help_OnClick()"}

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        Call SetVariables()
        With Response
            'Upper menu
            .Write(strMenu)
            'Generate Page Legends
            .Write("<BR>")
            .Write("<div id=divList style='overflow:auto'>")
            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
            .Write("<TR class=clsTREven>")
            .Write("<TD align=center>")
            Call GenerateReportGraph()
            .Write("</TD></TR>")
            .Write("</TABLE>")
            .Write("</div>")
            'Bottom menu
            .Write("<BR>")
            .Write(strMenu)
        End With
    End Sub
    Private Sub SetVariables()

        If Not Request.Form("hidWeekNo") Is Nothing Then
            m_intWeekNo = CType(Request.Form("hidWeekNo"), Integer)
        Else
            m_intWeekNo = 0
        End If

        CommonFunctions.General.WriteHTML("<input type='hidden' name='hidWeekNo' id='hidWeekNo' value='" + m_intWeekNo.ToString + "'>")

    End Sub
End Class
