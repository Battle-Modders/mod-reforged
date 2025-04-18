::Reforged.HooksMod.hook("scripts/entity/tactical/humans/officer", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Officer);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert")); // Given conditionally
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		// this.m.Skills.add(::new("scripts/skills/actives/rotation")); // Replaced by perk
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_blitzkrieg"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hold_steady"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_shield_sergeant"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exude_confidence"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rally_the_troops", function(o) {
			o.m.ActionPointCost = 1;
			o.m.Cooldown = 3;
		}));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();

		local weapon = this.getMainhandItem();
		if (weapon == null) return;

		if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		}
		else
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		}

		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		}
	}
});
