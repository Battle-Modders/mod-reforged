::Reforged.HooksMod.hook("scripts/entity/tactical/humans/conscript_polearm", function(q) {
	q.onInit = @() function()
	{
		this.conscript.onInit();

		//Reforged
		this.m.Skills.removeByID("perk.quick_hands");
		this.m.Skills.removeByID("perk.fast_adaption");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bolster"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_polearm"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_leverage"));
		}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();
	    local weapon = this.getMainhandItem();

	    if (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Mace))
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_mace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_rattle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_concussive_strikes"));
		}
		else
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_long_reach"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		}

	    if (::Reforged.Config.IsLegendaryDifficulty)
		{
			if (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Mace))
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_follow_up"));
			}
			else
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			}
		}
	}
});
