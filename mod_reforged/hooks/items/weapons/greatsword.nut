::Reforged.HooksMod.hook("scripts/items/weapons/greatsword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Zweihander";
		this.m.Reach = 7;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/overhead_strike"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split"));

		this.addSkill(::Reforged.new("scripts/skills/actives/swing"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}
});
