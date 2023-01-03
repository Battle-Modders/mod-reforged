::mods_hookExactClass("entity/tactical/enemies/bandit_leader", function(o) {
    o.onInit = function()
    {
       this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditLeader);
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
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_push_forward"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_hold_the_line"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_shields_up"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_whites_of_their_eyes"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_assured_conquest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_balance"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_exude_confidence"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_lithe"));
		}
	}

    local assignRandomEquipment = o.assignRandomEquipment;
    o.assignRandomEquipment = function()
    {
        assignRandomEquipment();
      	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_linebreaker"));
		}

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			local attack = this.getSkills().getAttackOfOpportunity();
			if (attack != null && attack.isDuelistValid())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perks_perk_rf_formidable_approach"));
			}
		}
    }

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.Skills.removeByID("perk.underdog");

			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));

			if (::Reforged.Config.IsLegendaryDifficulty)
			{
				local mainhandItem = this.getMainhandItem();

				if (mainhandItem != null && mainhandItem.isItemType(this.Const.Items.ItemType.TwoHanded))
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_sweeping_strikes"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bloody_harvest"));
				}

				else
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_double_strike"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
				}
			}
		}

		return ret;
	}
});
