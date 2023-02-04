::mods_hookExactClass("entity/tactical/humans/bounty_hunter", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BountyHunter);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		// b.IsSpecializedInDaggers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect")); // Replaced as perk
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced as perk
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced as perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced as perk

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));

			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);

			if (this.isArmedWithShield())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			}
			else if (this.m.Skills.hasSkill("actives.throw_net"))
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_angler"));
			}
			else if (this.getOffhandItem() == null)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				local weapon = this.getMainhandItem();
				if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_vigorous_assault"));
			}
		}
	}
});
