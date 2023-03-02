::mods_hookExactClass("items/weapons/greenskins/orc_javelin", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/throw_javelin", function(o) {
			o.m.FatigueCost += 1;
		}));
	}
});
