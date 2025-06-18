// This hook adds the retinue button to the tavern screen
Reforged.Hooks.WorldCampfireScreenAssets_createDIV = WorldCampfireScreenAssets.prototype.createDIV;
WorldCampfireScreenAssets.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.WorldCampfireScreenAssets_createDIV.call(this, _parentDiv);
	this.mFollowerToolAsset = this.createAssetDIV(_parentDiv, Path.GFX + Asset.rf_ICON_ASSET_FOLLOWER_TOOLS, 'is-generic-tools');
}

Reforged.Hooks.WorldCampfireScreenAssets_destroyDIV = WorldCampfireScreenAssets.prototype.destroyDIV;
WorldCampfireScreenAssets.prototype.destroyDIV = function ()
{
	Reforged.Hooks.WorldCampfireScreenAssets_destroyDIV.call(this);
    this.mFollowerToolAsset.remove();
    this.mFollowerToolAsset = null;
};

Reforged.Hooks.WorldCampfireScreenAssets_bindTooltips = WorldCampfireScreenAssets.prototype.bindTooltips;
WorldCampfireScreenAssets.prototype.bindTooltips = function ()
{
	Reforged.Hooks.WorldCampfireScreenAssets_bindTooltips.call(this);
   this.mFollowerToolAsset.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "Retinue.FollowerTools"});
};

Reforged.Hooks.WorldCampfireScreenAssets_unbindTooltips = WorldCampfireScreenAssets.prototype.unbindTooltips;
WorldCampfireScreenAssets.prototype.unbindTooltips = function ()
{
	Reforged.Hooks.WorldCampfireScreenAssets_unbindTooltips.call(this);
    this.mFollowerToolAsset.unbindTooltip();
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
};
