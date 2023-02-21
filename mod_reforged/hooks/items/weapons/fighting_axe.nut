::mods_hookExactClass("items/weapons/fighting_axe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
		this.m.ShieldDamage = 26;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost += 1
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 2;
			o.setApplyAxeMastery(true)
		}));
	}
});
