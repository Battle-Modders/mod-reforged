::mods_hookExactClass("items/weapons/wooden_stick", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
