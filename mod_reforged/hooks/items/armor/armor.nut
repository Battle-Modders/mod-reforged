::mods_hookExactClass("items/armor/armor", function(o) {
	local onUnequip = o.onUnequip;
	o.onUnequip = function()
	{
        if (this.getUpgrade() != null) this.setToBeRepaired(true);      // If an armor piece has an attachement you basically always want it repaired
		onUnequip();
	}
});
