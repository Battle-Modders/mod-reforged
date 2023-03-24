::mods_hookExactClass("items/weapons/dagger", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 1;

		// We reduce the maximum damage range so that highrolling a puncture is less impactful
		this.m.RegularDamageMax = 30;	// In Vanilla this is 35
		this.m.ArmorDamageMult = 0.65;	// In Vanilla this is 50
		this.m.DirectDamageAdd = 0.05;	// In Vanilla this is 0
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/stab", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/puncture", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
