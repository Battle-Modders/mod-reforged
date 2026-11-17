// New function to change Icon of Flee-Button when enemies gave up
TacticalScreenTopbarOptionsModule.prototype.changeFleeButtonToWin = function ()
{
	this.mFleeButton.changeButtonImage(Path.GFX + Reforged.Asset.BUTTON_RETREAT_WIN);
};

// Button that cycles the hit chance display mode (overlay / tooltip / both / off)
Reforged.HitchanceDisplayButtonImages = {
	"Overlay" : "ui/buttons/rf_hitchance_display_overlay.png",
	"Overlay + Tooltip" : "ui/buttons/rf_hitchance_display_both.png",
	"Tooltip" : "ui/buttons/rf_hitchance_display_tooltip.png",
	"Off" : "ui/buttons/rf_hitchance_display_off.png"
};

Reforged.Hooks.TopbarOptionsModule_createDIV = TacticalScreenTopbarOptionsModule.prototype.createDIV;
TacticalScreenTopbarOptionsModule.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.TopbarOptionsModule_createDIV.call(this, _parentDiv);

	var self = this;
	var mode = MSU.getSettingValue(Reforged.ID, "HitchanceDisplay_Mode");
	var image = Reforged.HitchanceDisplayButtonImages[mode] || Reforged.HitchanceDisplayButtonImages["Overlay"];
	var layout = $('<div class="rf-l-hitchance-display-button"/>');
	this.mContainer.append(layout);
	this.mRF_HitchanceDisplayButton = layout.createImageButton(Path.GFX + image, function ()
	{
		SQ.call(self.mSQHandle, 'RF_onHitchanceDisplayButtonPressed');
	}, '', 6);
};

Reforged.Hooks.TopbarOptionsModule_destroyDIV = TacticalScreenTopbarOptionsModule.prototype.destroyDIV;
TacticalScreenTopbarOptionsModule.prototype.destroyDIV = function ()
{
	if (this.mRF_HitchanceDisplayButton !== null && this.mRF_HitchanceDisplayButton !== undefined)
	{
		this.mRF_HitchanceDisplayButton.remove();
		this.mRF_HitchanceDisplayButton = null;
	}
	Reforged.Hooks.TopbarOptionsModule_destroyDIV.call(this);
};

Reforged.Hooks.TopbarOptionsModule_bindTooltips = TacticalScreenTopbarOptionsModule.prototype.bindTooltips;
TacticalScreenTopbarOptionsModule.prototype.bindTooltips = function ()
{
	Reforged.Hooks.TopbarOptionsModule_bindTooltips.call(this);
	this.mRF_HitchanceDisplayButton.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: 'HitchanceOverlay.DisplayButton' });
};

Reforged.Hooks.TopbarOptionsModule_unbindTooltips = TacticalScreenTopbarOptionsModule.prototype.unbindTooltips;
TacticalScreenTopbarOptionsModule.prototype.unbindTooltips = function ()
{
	Reforged.Hooks.TopbarOptionsModule_unbindTooltips.call(this);
	this.mRF_HitchanceDisplayButton.unbindTooltip();
};

TacticalScreenTopbarOptionsModule.prototype.RF_setHitchanceDisplayButtonState = function (_mode)
{
	if (this.mRF_HitchanceDisplayButton === null || this.mRF_HitchanceDisplayButton === undefined)
		return;

	var image = Reforged.HitchanceDisplayButtonImages[_mode];
	if (image === undefined)
		return;

	this.mRF_HitchanceDisplayButton.changeButtonImage(Path.GFX + image);
	this.mRF_HitchanceDisplayButton.updateTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: 'HitchanceOverlay.DisplayButton' });
};
