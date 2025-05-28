::Reforged.HooksMod.hook("scripts/items/weapons/oriental/heavy_southern_mace", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/bash"));

		this.addSkill(::Reforged.new("scripts/skills/actives/knock_out"));
	}}.onEquip;
});
