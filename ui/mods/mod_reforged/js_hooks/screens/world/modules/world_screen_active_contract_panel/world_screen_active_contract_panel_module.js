Reforged.Hooks.WorldScreenActiveContractPanelModule_createDIV = WorldScreenActiveContractPanelModule.prototype.createDIV;
WorldScreenActiveContractPanelModule.prototype.createDIV = function(_parentDiv)
{
	Reforged.Hooks.WorldScreenActiveContractPanelModule_createDIV.call(this, _parentDiv);
	this.mContentContainer.on("click.reforged", $.proxy(function()
	{
		SQ.call(this.mSQHandle, 'onActiveContractDetailsClicked');
	}, this));
}

Reforged.Hooks.WorldScreenActiveContractPanelModule_bindTooltips = WorldScreenActiveContractPanelModule.prototype.bindTooltips;
WorldScreenActiveContractPanelModule.prototype.bindTooltips = function ()
{
	Reforged.Hooks.WorldScreenActiveContractPanelModule_bindTooltips.call(this);
    this.mContentContainer.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "Contract.FocusOnObjective"});
};

Reforged.Hooks.WorldScreenActiveContractPanelModule_unbindTooltips = WorldScreenActiveContractPanelModule.prototype.unbindTooltips;
WorldScreenActiveContractPanelModule.prototype.unbindTooltips = function ()
{
	Reforged.Hooks.WorldScreenActiveContractPanelModule_unbindTooltips.call(this);
	this.mContentContainer.unbindTooltip();
};
