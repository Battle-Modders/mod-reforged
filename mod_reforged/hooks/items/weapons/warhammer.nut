::Reforged.HooksMod.hook("scripts/items/weapons/warhammer", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/hammer"));

		this.addSkill(::Reforged.new("scripts/skills/actives/crush_armor"));
	}}.onEquip;
});
