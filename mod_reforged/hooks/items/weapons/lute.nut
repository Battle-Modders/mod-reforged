::mods_hookExactClass("items/weapons/lute", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 2;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash"));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 10;
		}));
	}
});
