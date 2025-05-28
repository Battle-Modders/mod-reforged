::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_staff", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 4;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/bash", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 3;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}}.onEquip;
});
