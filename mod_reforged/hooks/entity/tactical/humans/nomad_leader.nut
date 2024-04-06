::Reforged.HooksMod.hook("scripts/entity/tactical/humans/nomad_leader", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.NomadLeader);
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
		this.getSprite("socket").setBrush("bust_base_nomads");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect")); Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		// {
		// 	this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		// }

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hold_steady"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rally_the_troops", function(o) {
			o.m.Cooldown = 3;
		}));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_shield_sergeant"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

	    local weapon = this.getMainhandItem();
	    if (weapon != null && weapon.isItemType(::Const.Items.ItemType.OneHanded) && this.getOffhandItem() == null)
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
	    }

	    if (this.isArmedWithShield())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_line_breaker"));
	    }

	    foreach (item in this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag))
	    {
	    	if (item.isItemType(::Const.Items.ItemType.RangedWeapon) && item.isWeaponType(::Const.Items.WeaponType.Throwing))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
	    		break;
	    	}
	    }
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.removeByID("perk.underdog");
			this.m.Skills.add(::new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_unstoppable"));
		}

		return ret;
	}
});
