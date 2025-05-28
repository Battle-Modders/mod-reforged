::Reforged.HooksMod.hook("scripts/items/weapons/fighting_spear", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/thrust"));

		this.addSkill(::Reforged.new("scripts/skills/actives/spearwall"));
	}}.onEquip;
});
