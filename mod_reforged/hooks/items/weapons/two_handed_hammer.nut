::mods_hookExactClass("items/weapons/two_handed_hammer", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
		this.m.ShieldDamage = 36;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/smite_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/shatter_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}
});
