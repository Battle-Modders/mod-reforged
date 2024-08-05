::Reforged.HooksMod.hook("scripts/items/weapons/warbrand", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 10;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/swing", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 10;
		}));
	}
});
