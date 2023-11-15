
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
	var offsets = {
		top  : targetOffset.top - containerHeight - offsetY,
		left : targetOffset.left
	}

	// If that would overflow the top of the screen, we instead display them below our cursor
	if (offsets.top < 0)
	{
		offsets.top = targetOffset.top + elementHeight + offsetY;
	}

	// If that would overflow the bottom of the screen, we instead display it starting directly at the top of the screen
	var wnd = this.mParent; // $(window);
	if ((offsets.top + containerHeight + offsetY) > wnd.height())
	{
		offsets.top = 10;

		// We also move it to the left or right (depending on the half of the screen we're in) to make sure it's not overlapping the cursor
		if (targetOffset.left > (wnd.width() / 2))
			offsets.left -= this.mContainer.outerWidth(true);
		else
			offsets.left += _targetDIV.outerWidth(true);
	}

	this.mContainer.css(offsets);
}
