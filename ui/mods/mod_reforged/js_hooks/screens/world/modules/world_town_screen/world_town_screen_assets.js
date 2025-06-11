// This hook adds the retinue button to the tavern screen
Reforged.Hooks.WorldTownScreenAssets_createDIV = WorldTownScreenAssets.prototype.createDIV;
WorldTownScreenAssets.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.WorldTownScreenAssets_createDIV.call(this, _parentDiv);
	var self = this;
	var assetContainer = $('<div class="l-tab-asset is-camp"></div>');
	this.mRetinueAsset = this.createImageButton(assetContainer, Path.GFX + Asset.ICON_CAMP, function()
	{
		self.mParent.notifyBackendRetinueButtonPressed();
	}, "", 6);
	_parentDiv.append(assetContainer);
}

Reforged.Hooks.WorldTownScreenAssets_destroyDIV = WorldTownScreenAssets.prototype.destroyDIV;
WorldTownScreenAssets.prototype.destroyDIV = function ()
{
	Reforged.Hooks.WorldTownScreenAssets_destroyDIV.call(this);
    this.mRetinueAsset.remove();
    this.mRetinueAsset = null;
};

Reforged.Hooks.WorldTownScreenAssets_bindTooltips = WorldTownScreenAssets.prototype.bindTooltips;
WorldTownScreenAssets.prototype.bindTooltips = function ()
{
	Reforged.Hooks.WorldTownScreenAssets_bindTooltips.call(this);
    this.mRetinueAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.RetinueButton });
};

Reforged.Hooks.WorldTownScreenAssets_unbindTooltips = WorldTownScreenAssets.prototype.unbindTooltips;
WorldTownScreenAssets.prototype.unbindTooltips = function ()
{
	Reforged.Hooks.WorldTownScreenAssets_unbindTooltips.call(this);
    this.mRetinueAsset.unbindTooltip();
};

Reforged.Hooks.WorldTownScreenAssets_loadFromData = WorldTownScreenAssets.prototype.loadFromData;
WorldTownScreenAssets.prototype.loadFromData = function (_data)
{
	Reforged.Hooks.WorldTownScreenAssets_loadFromData.call(this, _data);
    // if('Retinue' in currentAssetInformation)
    // {
    //    // TODO
    // }
};

// Add support to show retinue from town
WorldTownScreenAssets.prototype.notifyBackendRetinueButtonPressed = function()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onRetinueButtonPressed');
	}
}

