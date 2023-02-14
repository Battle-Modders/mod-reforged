::mods_hookExactClass("items/weapons/greenskins/orc_axe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ShieldDamage = 42;
		this.m.Reach = 3;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost += 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 3;
			o.setApplyAxeMastery(true);
		}));
	}
});
