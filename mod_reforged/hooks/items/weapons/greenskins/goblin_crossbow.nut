::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_crossbow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_stake"));

		local reload = ::Reforged.new("scripts/skills/actives/reload_bolt");
		this.addSkill(reload);
	}
});
