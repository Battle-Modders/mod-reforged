::Reforged.HooksMod.hook("scripts/items/weapons/noble_sword", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 4;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/slash"));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte"));
	}}.onEquip;
});
