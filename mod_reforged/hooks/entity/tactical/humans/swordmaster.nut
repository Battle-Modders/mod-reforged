::mods_hookExactClass("entity/tactical/humans/swordmaster", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Swordmaster);
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced by perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced by perk

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_finesse"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_double_strike"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_personal_armor"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		}
	}

	o.assignRandomEquipment = function()
	{
	    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/arming_sword"
			];

			if (this.Const.DLC.Wildmen || this.Const.DLC.Desert)
			{
				weapons.extend([
					"weapons/noble_sword",
					"weapons/arming_sword",
					"weapons/shamshir"
				]);
			}

			// Reforged start
			if (::Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/fencing_sword",
					"weapons/rf_estoc",
					"weapons/longsword"
				]);
			}
			// Reforged end

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				"armor/mail_shirt",
				"armor/mail_hauberk",
				"armor/basic_mail_shirt"
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

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 90)
		{
			local helmet = [
				"helmets/nasal_helmet",
				"helmets/nasal_helmet_with_mail",
				"helmets/mail_coif",
				"helmets/headscarf",
				"helmets/feathered_hat"
			];
			this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
		}

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

	    local weapon = this.getMainhandItem();
	    if (weapon.isItemType(::Const.Items.ItemType.RF_Fencing))
	    {
	    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_fencer"));
	    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_precise"));
	    }
	    else
	    {
	    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_blade_dancer"));
	    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_pattern_recognition"));
	    }
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_sword"
		];

		if (this.Const.DLC.Wildmen || this.Const.DLC.Desert)
		{
			weapons.extend([
				"weapons/named/named_sword",
				"weapons/named/named_shamshir"
			]);
		}

		// Reforged start
		if (::Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/named/named_fencing_sword",
				"weapons/named/named_rf_estoc"
			]);
		}
		// Reforged end

		local armor = [
			"armor/named/black_leather_armor",
			"armor/named/blue_studded_mail_armor"
		];

		if (this.Const.DLC.Wildmen)
		{
			armor.extend([
				"armor/named/named_noble_mail_armor"
			]);
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
		}

		// this.m.BaseProperties.DamageDirectMult *= 1.25; // Removed in Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));
		}

		return true;
	}
});
