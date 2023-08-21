
Reforged.Hooks.TooltipModule_setupTileTooltip = TooltipModule.prototype.setupTileTooltip;
TooltipModule.prototype.setupTileTooltip = function()
{
	Reforged.Hooks.TooltipModule_setupTileTooltip.call(this);

	// We do the mostly the same calculations as vanilla at first for getting the top position of our tooltip
	var containerHeight = this.mContainer.outerHeight(true);
	var posTop = this.mLastMouseY + (this.mCursorYOffset === 0 ? (this.mCursorHeight / 2) : (this.mCursorHeight - ((this.mCursorHeight / 2) - this.mCursorYOffset)) );

	if ((posTop + containerHeight) > this.mParent.height())
	{
		posTop = this.mLastMouseY - (this.mCursorYOffset === 0 ? ((this.mCursorHeight / 2) + containerHeight) : (this.mCursorYOffset + containerHeight));
	}

	// If the window would go beyond the top of the screen, we move it so it starts exactly at the top
	if (posTop < 0) posTop = 0;		// This line is new

	// apply the calculated topPos
	this.mContainer.css({ top: posTop });
}

Reforged.Hooks.TooltipModule_setupUITooltip = TooltipModule.prototype.setupUITooltip;
TooltipModule.prototype.setupUITooltip = function(_targetDIV, _data)
{
	Reforged.Hooks.TooltipModule_setupUITooltip.call(this, _targetDIV, _data);

	// We do the mostly the same calculations as vanilla at first for getting the top position of our tooltip
	if(_targetDIV === undefined) return;
	var offsetY = ('yOffset' in _data) ? _data.yOffset : this.mDefaultYOffset;
	if (offsetY !== null)
	{
		if (typeof(offsetY) === 'string')
		{
			offsetY = parseInt(offsetY, 10);
		}
		else if (typeof(offsetY) !== 'number')
		{
			offsetY = 0;
		}
	}

	var targetOffset    = _targetDIV.offset();
	var elementHeight   = _targetDIV.outerHeight(true);
	var containerHeight = this.mContainer.outerHeight(true);
	// By default we want the tooltips shown on top of the UI-Element
	var posTop  = targetOffset.top - containerHeight - offsetY;

	// If that would overflow the top of the screen, we instead display them below our cursor
	if (posTop < 0)
	{
		posTop = targetOffset.top + elementHeight + offsetY;
	}

	// If that would overflow the bottom of the screen, we instead display it starting directly at the top of the screen, consequentially overlapping with our UI-Element and cursor
	var wnd = this.mParent; // $(window);
	if ((posTop + containerHeight + offsetY) > wnd.height())
	{
		posTop = 10;
	}

	this.mContainer.css({ top: posTop });
}

Reforged.Hooks.TooltipModule_addAtmosphericImageDiv = TooltipModule.prototype.addAtmosphericImageDiv;
TooltipModule.prototype.addAtmosphericImageDiv = function(_parentDIV, _data)
{
	if (!('image' in _data) || typeof(_data.image) !== 'string' || _data.image.length === 0) return null;	// Copied from Vanilla

	var scaleString = Reforged.Asset.generateScaleCommand(_data.image);

	var ret = Reforged.Hooks.TooltipModule_addAtmosphericImageDiv.call(this, _parentDIV, _data);

	// var imageLayer = ret.find('.image-layer:first');
	var image = ret.find('img:first');
	image.css("transform", scaleString);

	return ret;
};

