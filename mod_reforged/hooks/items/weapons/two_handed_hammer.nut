::Reforged.HooksMod.hook("scripts/items/weapons/two_handed_hammer", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/smite_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/shatter_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}}.onEquip;
});
