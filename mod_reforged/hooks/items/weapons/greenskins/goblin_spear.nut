::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_spear", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/thrust", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 6;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
		}));
	}
});
