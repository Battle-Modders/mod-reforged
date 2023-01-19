::mods_hookExactClass("items/weapons/greenskins/orc_flail_2h", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/pound", function(o) {
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/thresh"));
	}
});
