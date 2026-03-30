::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/orc_flail_2h", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
		this.m.RegularDamage = 60; // vanilla 50
		this.m.RegularDamageMax = 110; // vanilla 100
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/pound"));

		this.addSkill(::Reforged.new("scripts/skills/actives/thresh"));
	}}.onEquip;
});
