<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page language="c#" %>
<script language="C#" runat="server">

// Messages
private string NoFileMessage = "No file selected";
private string UploadSuccessMessage = "Uploaded Sucess";
private string NoImagesMessage = "No Images";
private string NoFolderSpecifiedMessage = "No folder";
private string NoFileToDeleteMessage = "No file to delete";
private string InvalidFileTypeMessage = "Invalid file type";
private string[] AcceptedFileTypes = new string[] {"jpg","jpeg","jpe","gif","bmp","png"};

// Configuration
private bool	UploadIsEnabled = true;
private bool	DeleteIsEnabled = true;
private string	DefaultImageFolder = "images/RM/";

private void Page_Load(object sender, System.EventArgs e) {
	string isframe = "" + Request["frame"];
	
	if (isframe != "") {
		MainPage.Visible = true;
		iframePanel.Visible = false;
	
		string rif = "" + Request["rif"];
		string cif = "" + Request["cif"];	

		if (cif != "" && rif != "") {
			RootImagesFolder.Value = rif;
			CurrentImagesFolder.Value = cif;
		} else {
			RootImagesFolder.Value = DefaultImageFolder;
			CurrentImagesFolder.Value = DefaultImageFolder;	
		}

		UploadPanel.Visible = UploadIsEnabled;
		DeleteImage.Visible = DeleteIsEnabled;

		string FileErrorMessage = "";
		string ValidationString = ".*(";
		//[\.jpg]|[\.jpeg]|[\.jpe]|[\.gif]|[\.bmp]|[\.png])$"
		for (int i=0;i<AcceptedFileTypes.Length; i++) {
			ValidationString += "[\\." + AcceptedFileTypes[i] + "]";
			if (i < (AcceptedFileTypes.Length-1)) ValidationString += "|";
			FileErrorMessage += AcceptedFileTypes[i];
			if (i < (AcceptedFileTypes.Length-1)) FileErrorMessage += ", ";
		}
		FileValidator.ValidationExpression = ValidationString+")$";
		FileValidator.ErrorMessage=FileErrorMessage;

		if (!IsPostBack) {
			DisplayImages();
		}
	} else {
		
	}
}

public void UploadImage_OnClick(object sender, EventArgs e) {	
	if (Page.IsValid) {
		if (CurrentImagesFolder.Value != "") {
			if (UploadFile.PostedFile.FileName.Trim() != "") {
				if (IsValidFileType(UploadFile.PostedFile.FileName)) {
					try {
						string UploadFileName = "";
						string UploadFileDestination = "";
						UploadFileName = UploadFile.PostedFile.FileName;
						UploadFileName = UploadFileName.Substring(UploadFileName.LastIndexOf("\\")+1);
						UploadFileDestination = HttpContext.Current.Request.PhysicalApplicationPath;
						UploadFileDestination += CurrentImagesFolder.Value;
						UploadFileDestination += "\\";
						UploadFile.PostedFile.SaveAs(UploadFileDestination + UploadFileName);
						ResultsMessage.Text = UploadSuccessMessage;
					} catch(Exception ex) {
						//ResultsMessage.Text = "Your file could not be uploaded: " + ex.Message;
						ResultsMessage.Text = "There was an error.";
					}
				} else {
					ResultsMessage.Text = InvalidFileTypeMessage;
				}
			} else {
				ResultsMessage.Text = NoFileMessage;
			}
		} else {
			ResultsMessage.Text = NoFolderSpecifiedMessage;
		}
	} else {
		ResultsMessage.Text = InvalidFileTypeMessage;
		
	}
	DisplayImages();
}

public void DeleteImage_OnClick(object sender, EventArgs e) {
	if (FileToDelete.Value != "" && FileToDelete.Value != "undefined") {
		try {
			string AppPath = HttpContext.Current.Request.PhysicalApplicationPath;
			System.IO.File.Delete(AppPath  + CurrentImagesFolder.Value + "\\" + FileToDelete.Value);
			ResultsMessage.Text = "Deleted: " + FileToDelete.Value;
		} catch(Exception ex) {			
			ResultsMessage.Text = "There was an error.";
		}
	} else {
		ResultsMessage.Text = NoFileToDeleteMessage;
	}
	DisplayImages();
}

private bool IsValidFileType(string FileName) {
	string ext = FileName.Substring(FileName.LastIndexOf(".")+1,FileName.Length-FileName.LastIndexOf(".")-1);
	for (int i=0; i<AcceptedFileTypes.Length; i++) {		
		if (ext == AcceptedFileTypes[i]) {
			return true;
			
		}	
	}
	return false;
}


private string[] ReturnFilesArray() {
	if (CurrentImagesFolder.Value != "") {
		try {
			string AppPath = HttpContext.Current.Request.PhysicalApplicationPath;
			string ImageFolderPath = AppPath + CurrentImagesFolder.Value;
			string[] FilesArray = System.IO.Directory.GetFiles(ImageFolderPath,"*");
			return FilesArray;
			
			
		} catch {
		
			return null;
		}
	} else {
		return null;
	}

}

private string[] ReturnDirectoriesArray() {
	if (CurrentImagesFolder.Value != "") {
		try {
			string AppPath = HttpContext.Current.Request.PhysicalApplicationPath;
			string CurrentFolderPath = AppPath + CurrentImagesFolder.Value;
			string[] DirectoriesArray = System.IO.Directory.GetDirectories(CurrentFolderPath,"*");
			return DirectoriesArray ;
		} catch {
			return null;
		}
	} else {
		return null;
	}
}


public void DisplayImages() {
	string[] FilesArray = ReturnFilesArray();
	string[] DirectoriesArray = ReturnDirectoriesArray();
	string AppPath = HttpContext.Current.Request.PhysicalApplicationPath;
	string AppUrl;
	
	//Get the application's URL
	if (Request.ApplicationPath == "/")
		AppUrl = Request.ApplicationPath;
	else
		AppUrl = Request.ApplicationPath + "/";
	
	GalleryPanel.Controls.Clear();
	if ( (FilesArray == null || FilesArray.Length == 0) && (DirectoriesArray == null || DirectoriesArray.Length == 0) ) {
		gallerymessage.Text = NoImagesMessage + ": " + RootImagesFolder.Value;
	} else {
		string ImageFileName = "";
		string ImageFileLocation = "";

		int thumbWidth = 94;
		int thumbHeight = 94;
		
		if (CurrentImagesFolder.Value != RootImagesFolder.Value) {

			System.Web.UI.HtmlControls.HtmlImage myHtmlImage = new System.Web.UI.HtmlControls.HtmlImage();
			myHtmlImage.Src = AppUrl + "images/ftb/folder.up.gif";
			myHtmlImage.Attributes["unselectable"]="on"; 
			myHtmlImage.Attributes["align"]="absmiddle"; 
			myHtmlImage.Attributes["vspace"]="36"; 

			string ParentFolder = CurrentImagesFolder.Value.Substring(0,CurrentImagesFolder.Value.LastIndexOf("\\"));

			System.Web.UI.WebControls.Panel myImageHolder = new System.Web.UI.WebControls.Panel();					
			myImageHolder.CssClass = "imageholder";
			myImageHolder.Attributes["unselectable"]="on"; 
			myImageHolder.Attributes["onclick"]="divClick(this,'');";  
			myImageHolder.Attributes["ondblclick"]="gotoFolder('" + RootImagesFolder.Value + "','" + ParentFolder.Replace("\\","\\\\") + "');";  
			myImageHolder.Controls.Add(myHtmlImage);

			System.Web.UI.WebControls.Panel myMainHolder = new System.Web.UI.WebControls.Panel();
			myMainHolder.CssClass = "imagespacer";
			myMainHolder.Controls.Add(myImageHolder);

			System.Web.UI.WebControls.Panel myTitleHolder = new System.Web.UI.WebControls.Panel();
			myTitleHolder.CssClass = "titleHolder";
			myTitleHolder.Controls.Add(new LiteralControl("Up"));
			myMainHolder.Controls.Add(myTitleHolder);

			GalleryPanel.Controls.Add(myMainHolder);		
			
		}
		
		foreach (string _Directory in DirectoriesArray) {
			
			try {
				string DirectoryName = _Directory.ToString();
				

				System.Web.UI.HtmlControls.HtmlImage myHtmlImage = new System.Web.UI.HtmlControls.HtmlImage();
				myHtmlImage.Src = AppUrl + "images/ftb/folder.big.gif";
				myHtmlImage.Attributes["unselectable"]="on"; 
				myHtmlImage.Attributes["align"]="absmiddle"; 
				myHtmlImage.Attributes["vspace"]="29"; 

				System.Web.UI.WebControls.Panel myImageHolder = new System.Web.UI.WebControls.Panel();					
				myImageHolder.CssClass = "imageholder";
				myImageHolder.Attributes["unselectable"]="on"; 
				myImageHolder.Attributes["onclick"]="divClick(this);";  
				myImageHolder.Attributes["ondblclick"]="gotoFolder('" + RootImagesFolder.Value + "','" + DirectoryName.Replace(AppPath,"").Replace("\\","\\\\") + "');";  
				myImageHolder.Controls.Add(myHtmlImage);

				System.Web.UI.WebControls.Panel myMainHolder = new System.Web.UI.WebControls.Panel();
				myMainHolder.CssClass = "imagespacer";
				myMainHolder.Controls.Add(myImageHolder);

				System.Web.UI.WebControls.Panel myTitleHolder = new System.Web.UI.WebControls.Panel();
				myTitleHolder.CssClass = "titleHolder";
				myTitleHolder.Controls.Add(new LiteralControl(DirectoryName.Replace(AppPath + CurrentImagesFolder.Value + "\\","")));
				myMainHolder.Controls.Add(myTitleHolder);

				GalleryPanel.Controls.Add(myMainHolder);		
			} catch {
				// nothing for error
			}
		}
		
		foreach (string ImageFile in FilesArray) {

			try {

				ImageFileName = ImageFile.ToString();
				ImageFileName = ImageFileName.Substring(ImageFileName.LastIndexOf("\\")+1);
				ImageFileLocation = AppUrl;
				ImageFileLocation = ImageFileLocation.Substring(ImageFileLocation.LastIndexOf("\\")+1);
				//galleryfilelocation += "/";
				ImageFileLocation += CurrentImagesFolder.Value;
				ImageFileLocation += "/";
				ImageFileLocation += ImageFileName;
				System.Web.UI.HtmlControls.HtmlImage myHtmlImage = new System.Web.UI.HtmlControls.HtmlImage();
				myHtmlImage.Src = ImageFileLocation;
				System.Drawing.Image myImage = System.Drawing.Image.FromFile(ImageFile.ToString());
				myHtmlImage.Attributes["unselectable"]="on";  
				//myHtmlImage.border=0;

				// landscape image
				if (myImage.Width > myImage.Height) {
					if (myImage.Width > thumbWidth) {
						myHtmlImage.Width = thumbWidth;
						myHtmlImage.Height = Convert.ToInt32(myImage.Height * thumbWidth/myImage.Width);						
					} else {
						myHtmlImage.Width = myImage.Width;
						myHtmlImage.Height = myImage.Height;
					}
				// portrait image
				} else {
					if (myImage.Height > thumbHeight) {
						myHtmlImage.Height = thumbHeight;
						myHtmlImage.Width = Convert.ToInt32(myImage.Width * thumbHeight/myImage.Height);
					} else {
						myHtmlImage.Width = myImage.Width;
						myHtmlImage.Height = myImage.Height;
					}
				}
				
				if (myHtmlImage.Height < thumbHeight) {
					myHtmlImage.Attributes["vspace"] = Convert.ToInt32((thumbHeight/2)-(myHtmlImage.Height/2)).ToString(); 
				}


				System.Web.UI.WebControls.Panel myImageHolder = new System.Web.UI.WebControls.Panel();					
				myImageHolder.CssClass = "imageholder";
				myImageHolder.Attributes["onclick"]="divClick(this,'" + ImageFileName + "');";  
				myImageHolder.Attributes["ondblclick"]="returnImage('" + ImageFileLocation.Replace("\\","/") + "','" + myImage.Width.ToString() + "','" + myImage.Height.ToString() + "');";  
				myImageHolder.Controls.Add(myHtmlImage);


				System.Web.UI.WebControls.Panel myMainHolder = new System.Web.UI.WebControls.Panel();
				myMainHolder.CssClass = "imagespacer";
				myMainHolder.Controls.Add(myImageHolder);

				System.Web.UI.WebControls.Panel myTitleHolder = new System.Web.UI.WebControls.Panel();
				myTitleHolder.CssClass = "titleHolder";
				myTitleHolder.Controls.Add(new LiteralControl(ImageFileName + "<BR>" + myImage.Width.ToString() + "x" + myImage.Height.ToString()));
				myMainHolder.Controls.Add(myTitleHolder);

				//GalleryPanel.Controls.Add(myImage);
				GalleryPanel.Controls.Add(myMainHolder);
				
				myImage.Dispose();
			} catch {

			}
		}
		gallerymessage.Text = "";
	}
}
</script>
<asp:panel id="MainPage" runat="server" visible="false">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>Insert Image</title>
<style>

body {
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
	background: #ffffff; 
	width: 100%;
	overflow:hidden;
	border: 0;
}

body,tr,td {
	color: #000000;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10pt;
}

div.imagespacer {
	width: 120;
	height: 126;
	text-align: center;			
	float: left;
	font: 10pt verdana;
	margin: 5px;
	overflow: hidden;
}
div.imageholder {
	margin: 0px;
	padding: 0px;
	border: 1 solid #CCCCCC;
	width: 100;
	height: 100;
}

div.titleholder {
	font-family: ms sans serif, arial;
	font-size: 8pt;
	width: 100;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;			
}		

</style>


<script language="javascript">
lastDiv = null;
function divClick(theDiv,filename) {
	if (lastDiv) {
		lastDiv.style.border = "1 solid #CCCCCC";
	}
	lastDiv = theDiv;
	theDiv.style.border = "2 solid #316AC5";
	
	document.getElementById("FileToDelete").value = filename;

}
function gotoFolder(rootfolder,newfolder) {
	window.navigate("ftb.imagegallery.aspx?frame=1&rif=" + rootfolder + "&cif=" + newfolder);
}		
function returnImage(imagename,width,height) {
	var arr = new Array();
	arr["filename"] = imagename;  
	arr["width"] = width;  
	arr["height"] = height;			 
	window.parent.returnValue = arr;
	window.parent.close();	
}		
</script>		
</HEAD>
<body>
<table width=99.9% height=100% cellpadding=0 cellspacing=0 border=0>

<FORM encType="multipart/form-data" runat="server" ID="Form1">

<tr><td>
	<div id="galleryarea" style="width=100%; height:100%; overflow: auto;">
		<asp:label id="gallerymessage" runat="server"></asp:label>
		<asp:panel id="GalleryPanel" runat="server"></asp:panel>
	</div>
</td></tr>
<asp:Panel id="UploadPanel" runat="server">
<tr><td height=16 style="padding-left:10px;border-top: 1 solid #999999; background-color:#99ccff;">
	
	<table>
	<tr>
		<td valign=top><input id="UploadFile" type="file" name="UploadFile" runat="server" style="width:300;"/></td>
		<td valign=top><asp:button id="UploadImage" Text="Upload" runat="server" onclick="UploadImage_OnClick" /></td>
		<td valign=top><asp:button id="DeleteImage" Text="Delete" runat="server" onclick="DeleteImage_OnClick" /></td>
		<td valign=middle>		
	</tr>
	<tr>
		<td colspan=3>
			<asp:RegularExpressionValidator runat="server" 
				ControlToValidate="UploadFile" 
				id="FileValidator" display="dynamic"/>
			<asp:literal id="ResultsMessage" runat="server" />		
		</td>		
	</tr></table>	
	<input type="hidden" id="FileToDelete" Value="" runat="server" NAME="FileToDelete"/>
	<input type="hidden" id="RootImagesFolder" Value="images" runat="server" NAME="RootImagesFolder"/>
	<input type="hidden" id="CurrentImagesFolder" Value="images" runat="server" NAME="CurrentImagesFolder"/>
</td></tr>
</asp:panel>
</form>
</table>
</body>
</HTML>
</asp:panel>
<asp:panel id="iframePanel" runat="server" >
<html> 
<head><title>Insert Image</title></head>
<style>
body {
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
	background: #ffffff;
	overflow:hidden;
}
</style>
<body>
	<iframe style="width:100%;height:100%;border:0;" border=0 frameborder=0 src="ftb.imagegallery.aspx?frame=1&<%=Request.QueryString%>"></iframe>
</body>
</html>
</asp:panel>
