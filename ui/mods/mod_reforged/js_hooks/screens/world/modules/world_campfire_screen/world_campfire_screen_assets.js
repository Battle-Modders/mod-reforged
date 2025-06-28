// This hook adds the retinue button to the tavern screen
Reforged.Hooks.WorldCampfireScreenAssets_createDIV = WorldCampfireScreenAssets.prototype.createDIV;
WorldCampfireScreenAssets.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.WorldCampfireScreenAssets_createDIV.call(this, _parentDiv);
	this.mFollowerToolAsset = this.createAssetDIV(_parentDiv, Path.GFX + Asset.rf_ICON_ASSET_FOLLOWER_TOOLS, 'is-generic-tools');
	this.mFollowerCountAsset = this.createAssetDIV(_parentDiv, Path.GFX + Asset.rf_ICON_ASSET_FOLLOWER_TOOLS, 'is-follower-count');
}

Reforged.Hooks.WorldCampfireScreenAssets_destroyDIV = WorldCampfireScreenAssets.prototype.destroyDIV;
WorldCampfireScreenAssets.prototype.destroyDIV = function ()
{
	Reforged.Hooks.WorldCampfireScreenAssets_destroyDIV.call(this);
    this.mFollowerToolAsset.remove();
    this.mFollowerToolAsset = null;
    this.mFollowerCountAsset.remove();
    this.mFollowerCountAsset = null;
};

Reforged.Hooks.WorldCampfireScreenAssets_bindTooltips = WorldCampfireScreenAssets.prototype.bindTooltips;
WorldCampfireScreenAssets.prototype.bindTooltips = function ()
{
	Reforged.Hooks.WorldCampfireScreenAssets_bindTooltips.call(this);
   this.mFollowerToolAsset.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "Retinue.FollowerTools"});
   this.mFollowerCountAsset.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "Retinue.FollowerCount"});
};

Reforged.Hooks.WorldCampfireScreenAssets_unbindTooltips = WorldCampfireScreenAssets.prototype.unbindTooltips;
WorldCampfireScreenAssets.prototype.unbindTooltips = function ()
{
	Reforged.Hooks.WorldCampfireScreenAssets_unbindTooltips.call(this);
    this.mFollowerToolAsset.unbindTooltip();
    this.mFollowerCountAsset.unbindTooltip();
};

Reforged.Hooks.WorldCampfireScreenAssets_loadFromData = WorldCampfireScreenAssets.prototype.loadFromData;
WorldCampfireScreenAssets.prototype.loadFromData = function (_data)
{
	var previousAssetInformation = this.getValues();
	Reforged.Hooks.WorldCampfireScreenAssets_loadFromData.call(this, _data);
	var currentAssetInformation = _data;
	if('FollowerTools' in _data)
	{
		var value = currentAssetInformation["FollowerTools"];
	 	var valueDifference = null;
	 	if (previousAssetInformation !== null && 'FollowerTools' in previousAssetInformation && previousAssetInformation['FollowerTools'] !== null)
	 	{
	 	    previousValue = previousAssetInformation['FollowerTools'];
	 	    valueDifference = value - previousValue;
	 	}

	 	this.updateAssetValue(this.mFollowerToolAsset, value, null, valueDifference);
	}
	if('CurrentFollowerAmount' in _data)
	{
		var value = currentAssetInformation["CurrentFollowerAmount"];
	 	var valueDifference = null;
	 	if (previousAssetInformation !== null && 'CurrentFollowerAmount' in previousAssetInformation && previousAssetInformation['CurrentFollowerAmount'] !== null)
	 	{
	 	    previousValue = previousAssetInformation['CurrentFollowerAmount'];
	 	    valueDifference = value - previousValue;
	 	}

	 	this.updateAssetValue(this.mFollowerCountAsset, value, _data["MaxFollowerAmount"], valueDifference);
	 	var label = this.mFollowerCountAsset.find(".label:first");
	 	if (value == _data["MaxFollowerAmount"])
	 	{
			label.removeClass('font-color-assets-positive-value').addClass('font-color-assets-negative-value');
	 	}
	 	else
	 	{
	 		label.removeClass('font-color-assets-negative-value').addClass('font-color-assets-positive-value');
	 	}
	}
};
