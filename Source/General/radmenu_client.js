//
// r.a.d.menu script 2.7.2 rev 2702. (c) telerik
//

// *****************************
//  		RadMenuItem 
// *****************************
var tlrkKeyboard = null;
//Added RajeshB 14308
var delay = null;
var currentNode = null;
var itemToOpen = null;
var intFirstTime = 0;
function RadMenuItem(parentGroup, id)
{
	this.Image = null;
	this.ImageOver = null;
	this.PassOverState = false;
	this.Selected = false;
	this.Container = null;
	this.ParentGroup = parentGroup;	
	this.ChildGroup = null;
	this.Css = '';
	this.CssOver = '';
	this.CssClick = null;
	this.StatusBarTip = null;
	this.Left = null;
	this.LeftOver = null;
	this.Right = null;
	this.RightOver = null;
	this.ID = id;
	this.Key = null;
	this.Alt = false;
	this.Ctrl = false;
	this.Disabled = false;
	this.CancelAction = false;
	this.Label = null;
	this.Value = null;
	this.Category = null;
	
	this.HrefAction = null;
	this.PostbackAction = null;	
}

RadMenuItem.prototype.Select = function()
{	
	this.PassOverState = false;
	if (this.ChildGroup != null)
		if (this.ChildGroup.HideTimeoutId)
		{
			window.clearTimeout(this.ChildGroup.HideTimeoutId);
			this.ChildGroup.HideTimeoutId = 0;
		}
	if (this.ParentGroup.HideTimeoutId)	
	{
		window.clearTimeout(this.ParentGroup.HideTimeoutId);
		this.ParentGroup.HideTimeoutId = 0;	
	}
	
	if (this.ParentGroup.ParentItem != null)
	{
		var parentGroup = this.ParentGroup.ParentItem.ParentGroup;
		if (parentGroup.HideTimeoutId)
		{
			window.clearTimeout(parentGroup.HideTimeoutId);
			parentGroup.HideTimeoutId = 0;
		}
	}
	
	if (!this.Selected && (!this.Disabled))
	{
		this.ParentGroup.CloseChildGroups();		
		this.Selected = true;
		if (this.ParentGroup.LastSelected != null)
			if (this.ParentGroup.LastSelected != this)
				this.ParentGroup.LastSelected.UnSelectUnconditional();
		this.Highlight();		
		this.ParentGroup.LastSelected = this;		
	}
}


RadMenuItem.prototype.Highlight = function()
{	
	if (this.ImageOver != null)
	{		
		this.Container.getElementsByTagName("img")[0].src = this.ImageOver;		
	}
	else
	{
		this.Container.className = this.CssOver;		
		
		if (this.LeftOver != null)
		{			
			this.Container.getElementsByTagName("img")[0].src = this.LeftOver;
		}
		if (this.RightOver != null)
		{
			if (this.Left != null)
			{
				this.Container.getElementsByTagName("img")[1].src = this.RightOver;
			}
			else
			{				
				this.Container.getElementsByTagName("img")[0].src = this.RightOver;
			}
		}	
	}
	if (this.StatusBarTip != null)
	{
		window.status = this.StatusBarTip;
	}
	
	if (this.ParentGroup.ParentMenu.OnClientItemHighlight != null)
	{
		var s = this.ParentGroup.ParentMenu.OnClientItemHighlight + "(this);";		
		eval(s);		
	}
}

RadMenuItem.prototype.UnSelect = function()
{
	this.PassOverState = true;
	eval(this.ID + "_callBack = " + "this;");	
	window.setTimeout( this.ID + "_callBack.UnSelectTimeout()", 10);
}

RadMenuItem.prototype.UnSelectTimeout = function()
{	
	if (this.PassOverState && this.Selected)
	{
		this.UnSelectUnconditional();
	}
}

RadMenuItem.prototype.UnSelectUnconditional = function()
{
	this.Selected = false;
	if (this.ChildGroup != null && this.ChildGroup.Visible)
	{
	}
	else
	{
		if (this.Image != null)
		{
			this.Container.getElementsByTagName("img")[0].src = this.Image;
		}
		else
		{
			if (this.Left != null)
			{
				this.Container.getElementsByTagName("img")[0].src = this.Left;
			}
			if (this.Right != null)
			{
				if (this.Left != null)
				{
					this.Container.getElementsByTagName("img")[1].src = this.Right;
				}
				else
				{					
					this.Container.getElementsByTagName("img")[0].src = this.Right;
				}
			}
			
			this.Container.className = this.Css;						
		}
		
		if (this.StatusBarTip != null)
		{
			window.status = "";
		}
	}	
}

RadMenuItem.prototype.Click = function(e)
{
	if (this.CssClick != null)
	{
		this.Container.className = this.CssClick;
	}	
	
	if (this.ParentGroup.ParentMenu.OnClientClick != null)
	{
		var s = this.ParentGroup.ParentMenu.OnClientClick + "(this);";
		this.CancelAction = false;
		eval(s);
		this.ParentGroup.ParentMenu.CloseAllGroups();
		if (this.CancelAction)
		{
			return;
		}
	}	
	
	if (this.HrefAction != null)
	{
		eval(this.HrefAction);
		this.ParentGroup.ParentMenu.CloseAllGroups();
	}
	if (this.PostbackAction != null)
	{
		if (this.ParentGroup.ParentMenu.CausesValidation)
		{			
			if (typeof(Page_ClientValidate) != 'function' ||  Page_ClientValidate())
			{
				eval(this.PostbackAction);	
			}
		}
		else
		{
			eval(this.PostbackAction);
		}
		
		this.ParentGroup.ParentMenu.CloseAllGroups();
	}
}

// **********************
//		RadMenuGroup
// **********************
function RadMenuGroup()
{
	this.ParentMenu = null;
	this.HideTimeoutId = 0;
	this.ScrollTimeoutId = 0;
	this.ID = '';
	this.Container = null;
	this.Visible = false;
	this.ExpandDirection = "down";
	this.Items = new Array();
	this.ParentItem = null;
	this.OffsetX = 0;
	this.OffsetY = 0;
	this.Scroll = 0;
	this.ExpandEffect = null;
	this.LastSelected = null;
}

RadMenuGroup.prototype.AddItem = function(item)
{
	this.Items[this.Items.length] = item;
}

RadMenuGroup.prototype.CalcExpandX = function(container)
{
	switch (this.ExpandDirection)
	{
		case "down"  : return this.ParentMenu.getx(container);
		case "right" : return this.ParentMenu.getx(container) + container.offsetWidth;
		case "up"    : return this.ParentMenu.getx(container);
		case "left"  : return this.ParentMenu.getx(container) - this.Container.offsetWidth;
	}
}

RadMenuGroup.prototype.CalcExpandY = function(container)
{
	switch (this.ExpandDirection)
	{
		case "down"  : return this.ParentMenu.gety(container) + container.offsetHeight;
		case "right" : return this.ParentMenu.gety(container);
		case "up"    : return this.ParentMenu.gety(container) - this.Container.offsetHeight;
		case "left"  : return this.ParentMenu.gety(container);
	}
}

RadMenuGroup.prototype.ShowOverlay = function()
{	
	if (document.readyState == 'complete') 
	{
		if (this.ParentMenu.Overlay && this.ParentMenu.Browser == "IE6")
		{			
			var overID = this.ID + "_over";
			if (!document.getElementById(overID))
			{
				var elem = null;
				if (document.forms.length > 0)
				{
					elem = document.forms[0];
				}
				else
				{
					elem = document.body;
				}
				elem.insertAdjacentHTML("beforeEnd","<iframe id='" + overID + "' src='about:blank' + style='position:absolute;left:0px;top:0x;z-index:500;display:none' scrolling='no' frameborder='0'></iframe>");
			}
			if (document.getElementById(overID))
			{
				var overs = document.getElementById(overID).style;
				overs.top = this.Container.style.top;
				overs.left = this.Container.style.left;
				overs.width = this.Container.offsetWidth;
				overs.height = this.Container.offsetHeight;
				overs.filter = 'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';
				overs.display = 'block';
			}
		}
	}
}

RadMenuGroup.prototype.HideOverlay = function()
{
	if (this.ParentMenu.Overlay && this.ParentMenu.Browser == "IE6")
	{
		var overID = this.ID + "_over";
		if (document.getElementById(overID))
		{
			var overs = document.getElementById(overID).style;
			overs.display = 'none';
		}
	}
}

RadMenuGroup.prototype.Show = function(container)
{	
	if (!this.Visible)
	{
		if (this.ParentMenu.ClickToOpen && !this.ParentMenu.ClickToOpenFlag)
			return;
						
		if (this.Scroll)
		{
		
			//alert("scrolling");
			document.getElementById(this.ID + "_inner").style.top = "0px";
			this.DisableTopScrollImage();
			this.EnableBottomScrollImage();
		}
		
		
		if (this.ParentMenu.Browser == "IE6")
		{
			this.Container.style.filter = null;
			if (this.ExpandEffect)
			{
				this.Container.style.filter = this.ExpandEffect;
			}
			if (this.ParentMenu.Opacity > 0)
			{
				this.Container.style.filter += " progid:DXImageTransform.Microsoft.Alpha(Opacity="+ this.ParentMenu.Opacity + ");"
			}
			if (this.ParentMenu.ShadowWidth > 0)
			{			
				this.Container.style.filter += " progid:DXImageTransform.Microsoft.Shadow(Direction=135, Strength="+ this.ParentMenu.ShadowWidth + ",color=" + this.ParentMenu.ShadowColor + ");"
			}
			if (this.Container.filters[0] != null)
				this.Container.filters[0].Apply();
		}
		
		
		
		this.HideNonParentGroups();
		this.Visible = true;		
		var x = this.CalcExpandX(container);
		var y = this.CalcExpandY(container);
		/*
		Commented Out:RajeshB		22nd November, 2004*/
		this.Container.style.left = (parseInt(x) + parseInt(this.OffsetX));// + 'px';
		this.Container.style.top = (parseInt(y) + parseInt(this.OffsetY)) ;//+ 'px';		
	
		
		this.Container.style.visibility = 'visible';		
		this.Container.style.display = 'block';
		
		if (this.Scroll)
		{			
			
			//alert(document.getElementById(this.ID + "_inner").length)
			var _w = document.getElementById(this.ID + "_inner").firstChild.offsetWidth;
			document.getElementById(this.ID + "_bottom").firstChild.style.width = _w;
			document.getElementById(this.ID + "_top").firstChild.style.width = _w;
				//		this.Container.style.left = checkWidthBounds((parseInt(x) + parseInt(this.OffsetX)), this.Container.offsetWidth, this.ParentItem.Container.offsetWidth) + 'px';
			//this.Container.style.top = checkHeightBounds((parseInt(y) + parseInt(this.OffsetY)), this.Container.offsetHeight, this.ParentItem.Container.offsetHeight) + 'px';

		}
		//alert(this.Container.style.top);
		this.Container.style.left = checkWidthBounds(parseInt(this.Container.style.left) , this.Container.offsetWidth - this.ParentMenu.ShadowWidth , this.ParentItem.Container.offsetWidth) + 'px';
		//alert("Hi");
		//alert(checkHeightBounds((parseInt(y) + parseInt(this.OffsetY)), this.Container.offsetHeight, this.ParentItem.Container.offsetHeight) + 'px');
		this.Container.style.top = checkHeightBounds(parseInt(this.Container.style.top), this.Container.offsetHeight, this.ParentItem.Container.offsetHeight) + 'px';
		//alert("T:" + parseInt(this.Container.style.top) + "H:" + this.Container.offsetHeight + "PH:" + this.ParentItem.Container.offsetHeight + "SH:" +calculateHeight());
		
		this.ShowOverlay();
		
		if (this.ParentMenu.Browser == "IE6")
		{
			if (this.Container.filters[0] != null)
			{			
				this.Container.filters[0].Play();			
			}
		}
		
	}
}

RadMenuGroup.prototype.Hide = function()
{	
	if (!this.HideTimeoutId)
	{
		eval(this.ID + "_callBack = " + "this;");	
		this.HideTimeoutId = window.setTimeout( this.ID + "_callBack.HideTimeout(true)", this.ParentMenu.GroupHideDelay);		
	}
}

RadMenuGroup.prototype.HideTimeout = function(scheduleParent)
{
	if (this.Visible)
	{
		this.HideOverlay();
		this.Container.style.visibility = 'hidden';		
		this.Visible = false;
		this.ParentItem.UnSelectUnconditional();
		if (scheduleParent)
		{
			this.ScheduleParentForHiding();			
		}
		this.CloseChildGroups();
		
		eval(this.ID + "_callBack = " + "this;");	
		window.setTimeout( this.ID + "_callBack.ParentMenu.CheckClickToOpenCondition()", 200);
	} 
}

RadMenuGroup.prototype.CloseChildGroups = function()
{
	var i;
	for (i=0; i<this.Items.length; i++)
	{
		if (this.Items[i].ChildGroup != null)
		{
			this.Items[i].ChildGroup.HideTimeout(false);
		}
	}
}

RadMenuGroup.prototype.UnSelectAllItems = function()
{
	var i;
	for (i=0; i<this.Items.length; i++)	
	{
		if (this.Items[i].Selected)
			this.Items[i].UnSelectUnconditional();	
	}
}

RadMenuGroup.prototype.ScheduleParentForHiding = function()
{	
	eval(this.ID + "_callBack = " + "this;");
	this.ParentItem.ParentGroup.HideTimeoutId = window.setTimeout(this.ID + "_callBack.ParentItem.ParentGroup.HideTimeout(true);", this.ParentMenu.GroupHideDelay);
}

RadMenuGroup.prototype.HideNonParentGroups = function()
{
	var i;
	for (i=0; i<this.ParentMenu.AllGroups.length; i++)
		if (!this.IsParentGroup(this.ParentMenu.AllGroups[i]))
			this.ParentMenu.AllGroups[i].HideTimeout(false);
}

RadMenuGroup.prototype.IsParentGroup = function(group)
{
	var parentGroup = this;
	while (parentGroup.ParentItem != null)
	{
		parentGroup = parentGroup.ParentItem.ParentGroup;
		if (group.ID == parentGroup.ID)
			return true;
	}
	return false;	
}

RadMenuGroup.prototype.DoScroll = function(direction)
{
	if (this.ParentItem.ParentGroup != null)
	{
		if (this.ParentItem.ParentGroup.HideTimeoutId)
		{
			window.clearTimeout(this.ParentItem.ParentGroup.HideTimeoutId);
			this.ParentItem.ParentGroup.HideTimeoutId = 0;
		}
		if (this.HideTimeoutId)
		{
			window.clearTimeout(this.HideTimeoutId)
			this.HideTimeoutId = 0;
		}
	}
	
	
	this.StopScroll();
		
	
	eval(this.ID + "_callBack = " + "this;");
	this.ScrollTimeoutId = window.setTimeout(this.ID + "_callBack.DoTimeoutScroll('" + direction + "')", 20);	
}

RadMenuGroup.prototype.DoTimeoutScroll = function(direction)
{	
	window.clearTimeout(this.HideTimeoutId);
	var innerDiv = document.getElementById(this.ID + "_inner");
	var i_top = parseInt(innerDiv.style.top.replace("px",""));	
	
	if (direction == "up")
	{
		if (i_top < 0)	
		{
			i_top++;
			this.EnableBottomScrollImage();
		}
		else 
		{
			this.StopScroll();
			this.DisableTopScrollImage();
		}		
	}
	if (direction == "down")
	{		
		
		if ( (i_top)*(-1) + this.Scroll < innerDiv.offsetHeight)
		{
			i_top--;
			this.EnableTopScrollImage();
		}
		else
		{			
		
			this.StopScroll();
			this.DisableBottomScrollImage();			
		}
	}
	innerDiv.style.top = i_top + "px";
	
	eval(this.ID + "_callBack = " + "this;");
	this.ScrollTimeoutId = window.setTimeout(this.ID + "_callBack.DoTimeoutScroll('" + direction + "')", this.ParentMenu.ScrollSpeed);
}

RadMenuGroup.prototype.StopScroll = function()
{
	if (this.ScrollTimeoutId)
	{
		window.clearTimeout(this.ScrollTimeoutId);
		this.ScrollTimeoutId = 0;
	}
}

RadMenuGroup.prototype.DisableBottomScrollImage = function()
{
	var bcs = document.getElementById(this.ID + "_bottom").getElementsByTagName("img")[0].src;
	var ccs = bcs.substr(bcs.length - this.ParentMenu.ScrollDownDisabled.length, this.ParentMenu.ScrollDownDisabled.length);
	if (ccs != this.ParentMenu.ScrollDownDisabled)
		document.getElementById(this.ID + "_bottom").getElementsByTagName("img")[0].src = this.ParentMenu.ScrollDownDisabled;			
}

RadMenuGroup.prototype.EnableBottomScrollImage = function()
{
	var bcs = document.getElementById(this.ID + "_bottom").getElementsByTagName("img")[0].src;
	var ccs = bcs.substr(bcs.length - this.ParentMenu.ScrollDown.length, this.ParentMenu.ScrollDown.length);
	if (ccs != this.ParentMenu.ScrollDown)
		document.getElementById(this.ID + "_bottom").getElementsByTagName("img")[0].src = this.ParentMenu.ScrollDown;
}

RadMenuGroup.prototype.DisableTopScrollImage = function()
{
	var bcs = document.getElementById(this.ID + "_top").getElementsByTagName("img")[0].src;
	var ccs = bcs.substr(bcs.length - this.ParentMenu.ScrollUpDisabled.length, this.ParentMenu.ScrollUpDisabled.length);
	if (ccs != this.ParentMenu.ScrollUpDisabled)
		document.getElementById(this.ID + "_top").getElementsByTagName("img")[0].src = this.ParentMenu.ScrollUpDisabled;			
}

RadMenuGroup.prototype.EnableTopScrollImage = function()
{
	var bcs = document.getElementById(this.ID + "_top").getElementsByTagName("img")[0].src;
	var ccs = bcs.substr(bcs.length - this.ParentMenu.ScrollUp.length, this.ParentMenu.ScrollUp.length);
	if (ccs != this.ParentMenu.ScrollUp)
		document.getElementById(this.ID + "_top").getElementsByTagName("img")[0].src = this.ParentMenu.ScrollUp;
}
// *****************
//	 	RadMenu
// *****************
function RadMenu(rootgroup_id, isContext, overlay, outputCacheMode)
{	
	this.AllGroups = new Array();
	this.AllItems = new Array();
	this.RootGroup = new RadMenuGroup();
	this.RootGroup.ParentMenu = this;
	this.RootGroup.ID = rootgroup_id;
	this.ID = rootgroup_id;
	this.GroupHideDelay = 500;
	this.ClickToOpen = false;
	this.ClickToOpenFlag = false;
	this.ScrollUp = "";
	this.ScrollDown = "";
	this.ScrollUpDisabled = "";
	this.ScrollDownDisabled = "";
	this.ScrollSpeed = 20;
	this.IsContext = isContext;
	this.ContextHtmlElementID = null;
	this.ContextVisible = false;
	this.Overlay = overlay;
	this.Opacity = -1;
	this.ShadowWidth = -1;
	this.ShadowColor = "black";
	this.Browser = "uplevel";
	
	this.OnClientClick = null;
	this.OnClientItemHighlight = null;	
	this.CausesValidation = true;
	this.OutputCacheMode = outputCacheMode;
	
	this._groupMatch = null;
	this._itemMatch = null;
	
	this.PopulateGroup(this.RootGroup);
	
	if (isContext && !outputCacheMode)
	{
		document.oncontextmenu = this.OnContext;		
	}
	
	// keyboard support	
	if (!outputCacheMode)
	{
		tlrkKeyboard = this;
		document.onkeydown = this.OnKeyPress;
	}
	
	this.Browser = "Gecko";
	if (navigator.appName == "Microsoft Internet Explorer")
	{
		if (navigator.appVersion.indexOf("MSIE 5.5") > 0 || navigator.appVersion.indexOf("MSIE 6") > 0)
			this.Browser = "IE6";
	}
}

RadMenu.prototype.getx = function(obj) { var curleft = 0; if (obj.offsetParent)	{ while (obj.offsetParent) { curleft += obj.offsetLeft;	obj = obj.offsetParent;	} }	else if (obj.x)	curleft += obj.x; return curleft; }
RadMenu.prototype.gety = function(obj) { var curtop = 0; if (obj.offsetParent) { while (obj.offsetParent) {	curtop += obj.offsetTop; obj = obj.offsetParent; } } else if (obj.y) curtop += obj.y; return curtop; }

RadMenu.prototype.OnKeyPress = function()
{
	var i;
	var keyCode = event.keyCode;
	for (i=0; i< tlrkKeyboard.AllItems.length; i++)
	{		
		if (tlrkKeyboard.AllItems[i].Key == keyCode)
		{			
			var CurrentItem = tlrkKeyboard.AllItems[i];				
			
			if (CurrentItem.Alt)
				if (!event.altKey) continue;
			if (CurrentItem.Ctrl)
				if (!event.ctrlKey) continue;
			
			if (CurrentItem.JavascriptAction != null)
			{
				eval(CurrentItem.JavascriptAction);
			}
			if (CurrentItem.HrefAction != null)
			{
				eval(CurrentItem.HrefAction);
			}
			if (CurrentItem.PostbackAction != null)
			{
				eval(CurrentItem.PostbackAction);
			}
	
			event.keyCode = 65;
			event.returnValue = false;
		}
	}
}


RadMenu.prototype.PopulateGroup = function(group) 
{
	var i;
	var innerItems = document.getElementById(group.ID).getElementsByTagName("table");
	for (i=1; i<innerItems.length; i++)
	{
		var newItem = new RadMenuItem(group, innerItems[i].id);
		newItem.ParentGroup = group;
		newItem.Css = innerItems[i].getAttribute("rmCss"); if (newItem.Css == "") newItem.Css = null;
		newItem.CssOver = innerItems[i].getAttribute("rmCssOver"); if (newItem.CssOver == "") newItem.CssOver = null;
		newItem.CssClick = innerItems[i].getAttribute("rmCssClick"); if (newItem.CssClick == "") newItem.CssClick = null;
		newItem.StatusBarTip = innerItems[i].getAttribute("rmStatusBarTip"); if (newItem.StatusBarTip == "") newItem.StatusBarTip = null;
		newItem.Left = innerItems[i].getAttribute("rmLeft"); if (newItem.Left == "") newItem.Left = null;
		newItem.LeftOver = innerItems[i].getAttribute("rmLeftOver"); if (newItem.LeftOver == "") newItem.LeftOver = null;
		newItem.Right = innerItems[i].getAttribute("rmRight"); if (newItem.Right == "") newItem.Right = null;
		newItem.RightOver = innerItems[i].getAttribute("rmRightOver"); if (newItem.RightOver == "") newItem.RightOver = null;
		newItem.Image = innerItems[i].getAttribute("rmImage"); if (newItem.Image == "") newItem.Image = null;
		newItem.ImageOver = innerItems[i].getAttribute("rmImageOver"); if (newItem.ImageOver == "") newItem.ImageOver = null;
		newItem.Key = innerItems[i].getAttribute("rmKey");
		newItem.Disabled = innerItems[i].getAttribute("rmDisabled");
		if (innerItems[i].getAttribute("rmAlt") != null) newItem.Alt = true;
		if (innerItems[i].getAttribute("rmCtrl") != null) newItem.Ctrl = true;
		newItem.Container = innerItems[i];
		newItem.HrefAction = innerItems[i].getAttribute("rmHfAction");
		newItem.PostbackAction = innerItems[i].getAttribute("rmPbAction");		
		newItem.Label = innerItems[i].getAttribute("rmLab");
		newItem.Value = innerItems[i].getAttribute("rmVal");
		newItem.Category = innerItems[i].getAttribute("rmCat");
		if (newItem.Category == "Generated")
		{
			itemToOpen = newItem;
		}		
		this.AllItems[this.AllItems.length] = newItem;
				
		if (innerItems[i].getAttribute("rmChild") != null && innerItems[i].getAttribute("rmChild") != "")		
		{			
			var newGroup = new RadMenuGroup();
			newGroup.ID = innerItems[i].getAttribute("rmChild");
			newGroup.Container = document.getElementById(innerItems[i].getAttribute("rmChild"));
			newGroup.ParentItem = newItem;
			newGroup.ParentMenu = this;
			if (newGroup.Container != null)
			{
				if (newGroup.Container.getAttribute("rmExpDir") != null && newGroup.Container.getAttribute("rmExpDir")  != "") 
				{
					newGroup.ExpandDirection = newGroup.Container.getAttribute("rmExpDir");
				}
				if (newGroup.Container.getAttribute("rmOffsetX") != null && newGroup.Container.getAttribute("rmOffsetX") != "") 
				{
					newGroup.OffsetX = newGroup.Container.getAttribute("rmOffsetX"); 				
				}
				if (newGroup.Container.getAttribute("rmOffsetY") != null && newGroup.Container.getAttribute("rmOffsetY") != "") 
				{
					newGroup.OffsetY = newGroup.Container.getAttribute("rmOffsetY"); 				
				}
				if (newGroup.Container.getAttribute("rmScroll") != null && newGroup.Container.getAttribute("rmScroll") != "") 
				{
					newGroup.Scroll = parseInt(newGroup.Container.getAttribute("rmScroll"));
					newGroup.Scroll = 1;
				}
				if (newGroup.Container.getAttribute("rmExpandEffect") != null && newGroup.Container.getAttribute("rmExpandEffect") != "") 
				{
					newGroup.ExpandEffect = newGroup.Container.getAttribute("rmExpandEffect");
				}
			}
						
			this.AllGroups[this.AllGroups.length] = newGroup;
			this.PopulateGroup(newGroup);			
			newItem.ChildGroup = newGroup;			
		}		
		group.AddItem(newItem);		
	}
}

RadMenu.prototype.ShowGroup = function(container, group_id)
{
	this.GetGroup(group_id, this.RootGroup);
	var instance = this._groupMatch;
	instance.Show(container);
}

RadMenu.prototype.HideGroup = function(container, group_id)
{
	this.GetGroup(group_id, this.RootGroup);
	var instance = this._groupMatch;
	instance.Hide();
}

RadMenu.prototype.Scroll = function(group_id, direction)
{	
	this.GetGroup(group_id, this.RootGroup);
	var instance = this._groupMatch;	
	instance.DoScroll(direction);
}

RadMenu.prototype.StopScroll = function(group_id)
{	
	this.GetGroup(group_id, this.RootGroup);
	var instance = this._groupMatch;	
	instance.StopScroll();
}

RadMenu.prototype.Over = function(container)
{	
	this.GetItem(container.id, this.RootGroup);
	var instance = this._itemMatch;	
	instance.Select();
}

RadMenu.prototype.Out = function(container)
{
	this.GetItem(container.id, this.RootGroup)
	var instance = this._itemMatch;
	instance.UnSelect();
}

RadMenu.prototype.Click = function(container, e)
{
	this.GetItem(container.id, this.RootGroup)
	var instance = this._itemMatch;
	instance.Click(e);
}

RadMenu.prototype.GetItem = function(id, group)
{	
	var i;
	for (i=0; i<group.Items.length; i++)
	{
		if (group.Items[i].ID == id) this._itemMatch = group.Items[i];
		if (group.Items[i].ChildGroup != null)
			this.GetItem(id, group.Items[i].ChildGroup);
	}
}

RadMenu.prototype.GetGroup = function(id, group)
{
	var i;
	if (group.ID == id) this._groupMatch = group;
	for (i=0; i<group.Items.length; i++)
		if (group.Items[i].ChildGroup != null)
			this.GetGroup(id, group.Items[i].ChildGroup);
}

RadMenu.prototype.CloseAllGroups = function()
{
	var i;
	for (i=0; i<this.AllGroups.length; i++)
	{
		this.AllGroups[i].HideTimeout(false);
	}
	if (this.IsContext)
	{
		document.getElementById(this.RootGroup.ID).style.visibility = "hidden";
		this.ContextVisible = false;
	}
}

RadMenu.prototype.CheckClickToOpenCondition = function()
{
	var i;
	for (i=0; i<this.AllGroups.length; i++)
	{
		if (this.AllGroups[i].Visible)
			return;
	}
	this.ClickToOpenFlag = false;
}

RadMenu.prototype.OnContext = function()
{	
	var i;
	var menu;
	
	try	{ var dummy = tlrkContextMenus.length;	} catch (exception) { return; };	
	
	if (tlrkContextMenus.length == 1 && tlrkContextMenus[0].ContextHtmlElementID == null)
	{
		menu = document.getElementById(tlrkContextMenus[0].ID);		
		if (!tlrkContextMenus[0].ContextVisible)
		{			
			menu.style.left = event.x + document.body.scrollLeft + "px";
			menu.style.top = event.y + document.body.scrollTop + "px";
			menu.style.visibility = "visible";
			if (tlrkContextMenus[0].Overlay && tlrkContextMenus[0].Browser == "IE6")
			{
				var overID = tlrkContextMenus[0].ID + "_over";
				if (!document.getElementById(overID))
					document.body.insertAdjacentHTML("beforeEnd","<iframe id='" + overID + "' src='about:blank' style='position:absolute;left:0px;top:0x;z-index:499;display:none' scrolling='no' frameborder='0'></iframe>");
				if (document.getElementById(overID))
				{
					var overs = document.getElementById(overID).style;
					overs.top = event.y + document.body.scrollTop + "px";
					overs.left = event.x + document.body.scrollLeft + "px";
					overs.width = menu.offsetWidth;
					overs.height = menu.offsetHeight;
					overs.filter = 'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';
					overs.display = 'block';
				}
			}
			tlrkContextMenus[0].ContextVisible = true;
		}
		else
		{
			if (tlrkContextMenus[0].Overlay && tlrkContextMenus[0].Browser == "IE6")
			{
				var overID = tlrkContextMenus[0].ID + "_over";
				if (document.getElementById(overID))
				{
					var overs = document.getElementById(overID).style;
					overs.display = 'none';
				}
			}
			menu.style.visibility = "hidden";			
			tlrkContextMenus[0].ContextVisible = false;
			tlrkContextMenus[0].CloseAllGroups();
		}
		event.returnValue = false;		
	}
	else
	{
		for (i=0; i < tlrkContextMenus.length; i++)
		{
			menu = document.getElementById(tlrkContextMenus[i].ID);
			if (tlrkContextMenus[i].ContextVisible)
			{
				menu.style.visibility = 'hidden';
				tlrkContextMenus[i].ContextVisible = false;
				event.returnValue = false;
				continue;
			}			
			
			if (tlrkContextMenus[i].ContextHtmlElementID != null && document.getElementById(tlrkContextMenus[i].ContextHtmlElementID))
			{
				var elem = document.getElementById(tlrkContextMenus[i].ContextHtmlElementID);
				var x = tlrkContextMenus[i].getx(elem);
				var y = tlrkContextMenus[i].gety(elem);
				var width = elem.offsetWidth;
				var height = elem.offsetHeight;
				var x1 = event.x + window.document.body.scrollLeft;
				var y1 = event.y + window.document.body.scrollTop;
				if ((x1 > x) && (x1 < x + width) && (y1 > y) && (y1 < y + height))
				{
					menu.style.left = event.x + document.body.scrollLeft + "px";
					menu.style.top = event.y + document.body.scrollTop + "px";
					menu.style.visibility = "visible";				
					tlrkContextMenus[i].ContextVisible = true;
					event.returnValue = false;				
				} // if
			} // if
		} // for
	} // if
} // function
function resetNode()
{
//alert(intFirstTime);
if (intFirstTime == 0)
{
	//alert('clear');
	clearTimeout(delay);
}
intFirstTime = 0;

}
function showRequestedMenu()
{
document.getElementById("dd_i0").fireEvent("onmouseover"); 
document.getElementsByTagName("SPAN")[0].fireEvent("onmouseover"); 
document.getElementById(itemToOpen.ID).fireEvent("onmouseover"); 
//alert(document.getElementsByTagName("SPAN"));

}
function ProcessClientHover(node) { 

	//timeout in milliseconds.
	//var intTimeOut = 2000
	//var d = new Date
	if (node.Category == null)
	{
		if (node.StatusBarTip != null){
			currentNode = node;
			//Adding timeout...
			//while (
			//window.location.href = "Navigation.aspx?FromWhere=" + node.StatusBarTip;
			//alert(node.StatusBarTip);
			//set the mouseout first
			//document.getElementById(node.ID).onmouseout=function() { resetNode()}
			//set the delay
			intFirstTime = 1;
			document.getElementById(node.ID).onmouseout=function() 
			{ 
				resetNode()
			}
		
			delay =	setTimeout('ProcessTimedOutClientHover();', 2000);
				//intFirstTime = 0;
			//delay =	setTimeout('ProcessTimedOutClientHover();', 2000);
			
			
			
		}
		}	
} 
function ProcessTimedOutClientHover()
{

	window.location.href = "Navigation.aspx?FromWhere=" + currentNode.StatusBarTip;
}

function checkWidthBounds(currentx, width, plusWidth)
{
	var xmax = calculateWidth();
	//alert("MenuXmax:" + (currentx + width) + "Xmax:" + xmax);
	//alert(currentx + "," + width + "," + xmax)
	if ((currentx + width) > xmax)
	{
		//alert("overwidth");
		return (currentx - width - plusWidth);
	}
	else return currentx;	
}
function checkHeightBounds(currenty, height, plusHeight)
{
	var ymax = calculateHeight();
	if ((currenty + height) > ymax)
	{
		return (currenty - height + plusHeight);
	}
	else return currenty;	
}

function calculateWidth(currenty, height)
{
	if (document.layers) 
	{
		return window.innerWidth+window.pageXOffset;
	}else if (document.all)
	{
		return document.body.clientWidth+document.body.scrollLeft;
	}else if (document.getElementById)
	{
		return window.innerWidth+window.pageXOffset;
	}
}
function calculateHeight()
{
	if (document.layers) 
	{
		return window.innerHeight+window.pageYOffset;
	}else if (document.all)
	{
		return document.body.clientHeight+document.body.scrollTop;
	}else if (document.getElementById)
	{
		return window.innerHeight+window.pageYOffset;
	}
}


