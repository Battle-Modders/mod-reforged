Reforged.Hooks.WorldScreenActiveContractPanelModule_createDIV = WorldScreenActiveContractPanelModule.prototype.createDIV;
WorldScreenActiveContractPanelModule.prototype.createDIV = function(_parentDiv)
{
	var self = this;
	Reforged.Hooks.WorldScreenActiveContractPanelModule_createDIV.call(this, _parentDiv);
	this.mContentContainer.on("click.reforged", function()
	{
		SQ.call(self.mSQHandle, 'onActiveContractDetailsClicked');
	});
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
