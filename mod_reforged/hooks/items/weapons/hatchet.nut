::mods_hookExactClass("items/weapons/hatchet", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 2;
		this.m.ShieldDamage = 14;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost -= 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
			o.m.FatigueCost -= 3;
		}));
	}
});
