::Reforged.HooksMod.hook("scripts/items/weapons/wonky_bow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/quick_shot", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/aimed_shot", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
