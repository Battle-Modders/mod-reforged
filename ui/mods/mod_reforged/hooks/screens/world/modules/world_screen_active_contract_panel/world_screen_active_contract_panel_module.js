Reforged.Hooks.WorldScreenActiveContractPanelModule_createDIV = WorldScreenActiveContractPanelModule.prototype.createDIV;
WorldScreenActiveContractPanelModule.prototype.createDIV = function(_parentDiv)
{
	Reforged.Hooks.WorldScreenActiveContractPanelModule_createDIV.call(this, _parentDiv);
	this.mContentContainer.on("click.reforged", $.proxy(function()
	{
		SQ.call(this.mSQHandle, 'onActiveContractDetailsClicked');
	}, this));
}
