::mods_hookExactClass("items/weapons/knife", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 1;

		// We reduce the maximum damage range so that highrolling a puncture is less impactful
		this.m.RegularDamageMax = 20;	// In Vanilla this is 25
		this.m.ArmorDamageMult = 0.55;	// In Vanilla this is 50
		this.m.DirectDamageAdd = 0.05;	// In Vanilla this is 0
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/stab", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/puncture", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
