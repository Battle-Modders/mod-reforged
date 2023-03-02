::mods_hookExactClass("items/weapons/three_headed_flail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cascade_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/hail_skill"));
	}
});
