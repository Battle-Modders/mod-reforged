var modReforged_TooltipModule_setupUITooltip = TooltipModule.prototype.setupUITooltip;
TooltipModule.prototype.setupUITooltip = function(_targetDIV, _data)
{
	modReforged_TooltipModule_setupUITooltip.call(this, _targetDIV, _data);
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

	var wnd = this.mParent; // $(window);

	// calculate tooltip position
	var targetOffset    = _targetDIV.offset();
	var elementHeight   = _targetDIV.outerHeight(true);
	var containerHeight = this.mContainer.outerHeight(true);

	var posTop = null;

	// MOD_TOOLTIP_EXTENSION: attempts to prevent the tooltip from extending outside of the screen
	var posTopPrimary = targetOffset.top - containerHeight - offsetY;
	var posTopSecondary = targetOffset.top + elementHeight + offsetY;
	if (posTopPrimary < 0 && posTopSecondary + containerHeight > wnd.height())
	{
		posTop = (wnd.height() - containerHeight) / 2;
	}
	else if (posTopPrimary >= 0)
	{
		posTop = posTopPrimary;
	}
	else if (posTopSecondary + containerHeight <= wnd.height())
	{
		posTop = posTopSecondary;
	}

	if (posTop === null) return;

	// show & position tooltip & animate
	this.mContainer.css({ top: posTop });
};
