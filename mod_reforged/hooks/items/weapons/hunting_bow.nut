::Reforged.HooksMod.hook("scripts/items/weapons/hunting_bow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/quick_shot", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/aimed_shot", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
