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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_hold_steady"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rally_the_troops", function(o) {
			o.m.Cooldown = 3;
		}));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_shield_sergeant"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_proximity_throwing_specialist"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_battle_fervor"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_skirmisher"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_exude_confidence"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_poise"));
		}
	}

	o.assignRandomEquipment = function()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/fighting_axe",
				"weapons/warhammer",
				"weapons/fighting_spear",
				"weapons/winged_mace",
				"weapons/arming_sword",
				"weapons/military_cleaver"
			];

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/warbrand",

					// Reforged
					"weapons/rf_greatsword",
					"weapons/rf_battle_axe",
					"weapons/rf_swordstaff",
					"weapons/rf_kriegsmesser"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/wooden_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (this.Math.rand(1, 100) <= 35)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];
			this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local armor = [
				"armor/reinforced_mail_hauberk",
				"armor/worn_mail_shirt",
				"armor/patched_mail_shirt",
				"armor/mail_shirt"
			];

			if (this.Const.DLC.Unhold)
			{
				armor.extend([
					"armor/footman_armor",
					"armor/leather_scale_armor",
					"armor/light_scale_armor"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local helmet = [
				"helmets/closed_mail_coif",
				"helmets/padded_kettle_hat",
				"helmets/kettle_hat_with_closed_mail",
				"helmets/kettle_hat_with_mail",
				"helmets/padded_flat_top_helmet",
				"helmets/nasal_helmet_with_mail",
				"helmets/flat_top_with_mail",
				"helmets/padded_nasal_helmet",
				"helmets/bascinet_with_mail"
			];
			this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
		}

      	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_line_breaker"));
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
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_formidable_approach"));
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
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_death_dealer"));
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
