::Reforged.HooksMod.hook("scripts/items/weapons/bludgeon", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/bash", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}}.onEquip;
});
