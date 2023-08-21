::mods_hookExactClass("items/weapons/greenskins/orc_flail_2h", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
		this.m.FlipIconX = true;
		this.m.FlipIconLargeY = true;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/pound"));

		this.addSkill(::MSU.new("scripts/skills/actives/thresh"));
	}
});
