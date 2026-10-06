<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calendar.aspx.vb" Inherits="PbNIT.Calendar" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.Calendar", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	<asp:literal id="Literal1" runat="server"></asp:literal>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table>
				<TR vAlign="top">
					<TD width=22px align=left><b><asp:linkbutton id="LinkYearM5" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD width=22px><b><asp:linkbutton id="LinkYearM4" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD width=22px><b><asp:linkbutton id="LinkYearM3" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD width=22px><b><asp:linkbutton id="LinkYearM2" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD width=22px><b><asp:linkbutton id="LinkYearM1" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD><asp:dropdownlist id="cboYears" runat="server" Width="64px" CssClass="clsComboBox" AutoPostBack="True"></asp:dropdownlist></TD>
					<TD width=22px><b><asp:linkbutton id="LinkYearP1" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD width=22px><b><asp:linkbutton id="LinkYearP2" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD width=22px><b><asp:linkbutton id="LinkYearP3" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD width=22px><b><asp:linkbutton id="LinkYearP4" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
					<TD width=22px align=right><b><asp:linkbutton id="LinkYearP5" runat="server" CssClass="Menu">44</asp:linkbutton></b></TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" border="0" ms_2d_layout="TRUE">
				<TR vAlign="top">
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkJan" runat="server" CssClass="Menu" ToolTip="January">JAN</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkFeb" runat="server" CssClass="Menu" ToolTip="February">FEB</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkMar" runat="server" CssClass="Menu" ToolTip="March">MAR</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkApr" runat="server" CssClass="Menu" ToolTip="April">APR</asp:linkbutton></B></font> </td>
					<td><font face="Verdana" size="1"><B><asp:linkbutton id="LinkMay" runat="server" CssClass="Menu" ToolTip="May">MAY</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkJun" runat="server" CssClass="Menu" ToolTip="June">JUN</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkJul" runat="server" CssClass="Menu" ToolTip="July">JUL</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkAug" runat="server" CssClass="Menu" ToolTip="August">AUG</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkSep" runat="server" CssClass="Menu" ToolTip="September">SEP</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkOct" runat="server" CssClass="Menu" ToolTip="October">OCT</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkNov" runat="server" CssClass="Menu" ToolTip="November">NOV</asp:linkbutton></B></font> </TD>
					<TD><font face="Verdana" size="1"><B><asp:linkbutton id="LinkDec" runat="server" CssClass="Menu" ToolTip="December">DEC</asp:linkbutton></B></font> </TD>
				</TR>
			</TABLE>
			<hr width="330">
			<font face="Verdana" size="1">
			<asp:calendar id="Calendar1" runat="server" BorderWidth="1px" BackColor="#FEF7F1" Height="120px"
							Width="328px" NextPrevFormat="ShortMonth">
				<TodayDayStyle ForeColor="Red" BorderStyle="Inset" BorderColor="#DFE7EC" BackColor="#F7FCFE"></TodayDayStyle>
				<SelectorStyle BorderStyle="Double"></SelectorStyle>
				<DayStyle BackColor="#F7FCFE"></DayStyle>
				<NextPrevStyle Wrap="False"></NextPrevStyle>
				<DayHeaderStyle BorderStyle="Outset" BackColor="#BACBD8"></DayHeaderStyle>
				<SelectedDayStyle ForeColor="Red" BorderStyle="Inset" BorderColor="#DFE7EC" BackColor="#F7FCFE"></SelectedDayStyle>
				<TitleStyle ForeColor="White" BorderStyle="Groove" BorderColor="White"
							BackColor="SteelBlue"></TitleStyle>
				<OtherMonthDayStyle ForeColor="White" BorderColor="White" BackColor="#E6E6E6"></OtherMonthDayStyle>
			</asp:calendar>
			</font>
			<table><tr>
				<td width=70%></td>
				<TD align=right><asp:linkbutton id="lnkBtnClearAndClose" runat="server" Width="89px" Font-Names="Verdana" Font-Bold="True"
									EnableViewState="False" CssClass="Normal" ToolTip="Clear Selected Date and close the window">Clear & Close</asp:linkbutton>
				</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
