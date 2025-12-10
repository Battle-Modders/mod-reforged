::Reforged.HooksMod.hook("scripts/items/weapons/three_headed_flail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 4;
		this.m.Condition = 90.0; // vanilla 60.0
		this.m.ConditionMax = 90.0;	// vanilla 60.0
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cascade_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/hail_skill"));
	}}.onEquip;
});
