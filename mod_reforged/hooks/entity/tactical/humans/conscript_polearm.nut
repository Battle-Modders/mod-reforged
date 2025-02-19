::Reforged.HooksMod.hook("scripts/entity/tactical/humans/conscript_polearm", function(q) {
	q.onInit = @() function()
	{
		this.conscript.onInit();

		// Reforged
		this.m.Skills.removeByID("perk.dodge");
	}

	q.onSpawned = @() function()
	{
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));

		local weapon = this.getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Mace))
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
		}
		else
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		}
	}
});
