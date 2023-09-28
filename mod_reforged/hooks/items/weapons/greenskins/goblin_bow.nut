::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_bow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 1;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/quick_shot", function(o) {
			o.m.FatigueCost -= 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/aimed_shot", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
