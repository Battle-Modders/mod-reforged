::mods_hookExactClass("items/weapons/heavy_crossbow", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_bolt"));

		local reload = ::MSU.new("scripts/skills/actives/reload_bolt", function(o) {
			o.m.ActionPointCost += 1;
		});
		this.addSkill(reload);
	}
});
