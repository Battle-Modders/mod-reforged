::mods_hookNewObject("entity/world/settlement_modifiers", function(o) {
	o.BeastPartsPriceMult = 2.0;

	local reset = o.reset;
	o.reset = function()
	{
		reset();
		this.BeastPartsPriceMult = 2.0;
	}
});
