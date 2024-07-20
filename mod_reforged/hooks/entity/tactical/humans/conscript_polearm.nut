::Reforged.HooksMod.hook("scripts/entity/tactical/humans/conscript_polearm", function(q) {
	q.onInit = @() function()
	{
		this.conscript.onInit();
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();
	    local weapon = this.getMainhandItem();

	    if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Mace))
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		}
		else
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		}
	}

	q.onSetupEntity = @() function()
	{
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_polearm"));
	}
});
