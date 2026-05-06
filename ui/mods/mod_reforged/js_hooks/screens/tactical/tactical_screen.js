Reforged.Hooks.TacticalScreen_createDIV = TacticalScreen.prototype.createDIV;
TacticalScreen.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.TacticalScreen_createDIV.call(this, _parentDiv);
	// New elements, similar to how WorldScreenTopbarDayTimeModule does it

	this.mRF_PausedWrapper = $('<div class="rf-paused-wrapper rf-hidden"/>');
	this.mRF_PausedDiv = $('<div class="display-none title-font-very-big rf-paused-label font-color-title font-shadow-silhouette">PAUSED</div>');
	this.mRF_PausedSpacebarDiv = $('<div class="display-none text-font-small rf-paused-spacebar-label font-color-title font-shadow-silhouette">(Press Spacebar)</div>');
	this.mRF_PausedWrapper.append(this.mRF_PausedDiv);
	this.mRF_PausedWrapper.append(this.mRF_PausedSpacebarDiv);

	this.mContainer.append(this.mRF_PausedWrapper);
}

Reforged.Hooks.TacticalScreen_destroyDIV = TacticalScreen.prototype.destroyDIV;
TacticalScreen.prototype.destroyDIV = function ()
{
	this.mRF_PausedWrapper.remove();
	this.mRF_PausedWrapper = null;
	this.mRF_PausedDiv = null;
	this.mRF_PausedSpacebarDiv = null;
	Reforged.Hooks.TacticalScreen_destroyDIV.call(this);
}

{	// New Functions
	TacticalScreen.prototype.RF_showMessage = function(_data)
	{
		this.mRF_PausedDiv.html(_data.Header);
		this.mRF_PausedSpacebarDiv.html(_data.Subheader);

		this.mRF_PausedWrapper.removeClass('rf-hidden');
	}

	TacticalScreen.prototype.RF_hideMessage = function()
	{
		this.mRF_PausedWrapper.addClass('rf-hidden');
	}
}
