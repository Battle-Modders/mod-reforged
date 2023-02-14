::mods_hookExactClass("items/weapons/hatchet", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ShieldDamage = 14;
		this.m.Reach = 2;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
		}));
	}
});
