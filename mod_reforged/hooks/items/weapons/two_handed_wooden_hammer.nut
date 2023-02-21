::mods_hookExactClass("items/weapons/two_handed_wooden_hammer", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
		this.m.ShieldDamage = 22;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/smite_skill", function(o) {
			o.m.ActionPointCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/shatter_skill", function(o) {
			o.m.ActionPointCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 1;
			o.m.FatigueCost += 5;
		}));
	}
});
