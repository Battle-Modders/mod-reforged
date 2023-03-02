::mods_hookExactClass("items/weapons/fighting_spear", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/thrust"));

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall"));
	}
});
