::Reforged.HooksMod.hook("scripts/entity/tactical/humans/caravan_hand", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.CaravanHand);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_caravan");
		this.getSprite("dirt").Visible = true;
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_fruits_of_labor"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			local weapon = this.getMainhandItem();

			if (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Sword))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 2);
			}

			else
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 1);
			}
		}
	}
});
