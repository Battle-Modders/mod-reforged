::mods_hookExactClass("items/weapons/woodcutters_axe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
		this.m.ShieldDamage = 30;
		this.m.FlipIconX = true;
		this.m.FlipIconLargeX = true;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/split_man", function(o) {
			o.m.ActionPointCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/round_swing", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 1;
			o.m.FatigueCost += 5;
			o.setApplyAxeMastery(true);
		}));
	}
});
