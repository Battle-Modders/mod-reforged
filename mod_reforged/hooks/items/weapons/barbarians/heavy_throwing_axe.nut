::mods_hookExactClass("items/weapons/barbarians/heavy_throwing_axe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/throw_axe", function(o) {
			o.m.FatigueCost += 3;
		}));
	}
});
