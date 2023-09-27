::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/orc_flail_2h", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
		this.m.PoiseDamage = 40;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/pound"));

		this.addSkill(::MSU.new("scripts/skills/actives/thresh"));
	}
});
