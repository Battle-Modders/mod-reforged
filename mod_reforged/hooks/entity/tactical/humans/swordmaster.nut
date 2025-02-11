::Reforged.HooksMod.hook("scripts/entity/tactical/humans/swordmaster", function(q) {
	q.m.SwordmasterVariants <- {
		BladeDancer = 0,
		Metzger = 1,
		Reaper = 2,
		Precise = 3,
		Versatile = 4
	};
	q.m.MyArmorVariant <- 0; // 0 = Light Armor, 1 = Medium Armor
	q.m.MyVariant <- 0;

	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Swordmaster);
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));

		this.m.MyVariant = ::MSU.Table.randValue(this.m.SwordmasterVariants);

		switch(this.m.MyVariant)
		{
			case this.m.SwordmasterVariants.Precise: // light armor only
				this.m.MyArmorVariant = 0;
				break;

			case this.m.SwordmasterVariants.Reaper:  // medium armor only
			case this.m.SwordmasterVariants.Versatile:
				this.m.MyArmorVariant = 1;
				this.getAIAgent().m.Properties.BehaviorMult[::Const.AI.Behavior.ID.LineBreaker] = 10.0;
				this.getAIAgent().m.Properties.BehaviorMult[::Const.AI.Behavior.ID.KnockBack] = 10.0;
				break;

			case this.m.SwordmasterVariants.BladeDancer: // light or medium armor
			case this.m.SwordmasterVariants.Metzger:
				this.m.MyArmorVariant = ::Math.rand(0, 1); // 0 = Light Armor, 1 = Medium Armor
				break;
		}
	}

	q.assignRandomEquipment = @() function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor;
			if (this.m.MyArmorVariant == 0) // light armor
			{
				armor = "scripts/items/armor/noble_mail_armor";
			}
			else // medium armor
			{
				armor = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/rf_breastplate"],
					[1, "scripts/items/armor/rf_brigandine_armor"]
				]).roll();
			}

			this.m.Items.equip(::new(armor));

			if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier3)
			{
				local armorAttachment = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor_upgrades/direwolf_pelt_upgrade"],
					[1, "scripts/items/armor_upgrades/leather_shoulderguards_upgrade"],
					[1, "scripts/items/armor_upgrades/double_mail_upgrade"]
				]).roll();

				if (armorAttachment != null)
					this.getBodyItem().setUpgrade(::new(armorAttachment));
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = null;
			if (this.m.MyArmorVariant == 0) // light armor
			{
				helmet = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/mail_coif"],
					[1, "scripts/items/helmets/greatsword_hat"],
					[1, "scripts/items/helmets/reinforced_mail_coif"],
					[1, "scripts/items/helmets/nasal_helmet"]
				]).roll();
			}
			else // medium armor
			{
				helmet = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/rf_greatsword_helm"],
					[1, "scripts/items/helmets/nasal_helmet_with_mail"]
				]).roll();
			}
		this.m.Items.equip(::new(helmet));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon;
			switch(this.m.MyVariant)
			{
				case this.m.SwordmasterVariants.BladeDancer:
					weapon = ::MSU.Class.WeightedContainer([
						[1, "scripts/items/weapons/longsword"],
						[1, "scripts/items/weapons/rf_greatsword"],
						[1, "scripts/items/weapons/noble_sword"],
						[1, "scripts/items/weapons/warbrand"]
					]).roll();
					break;

				case this.m.SwordmasterVariants.Versatile:
					weapon = "scripts/items/weapons/greatsword";
					break;

				case this.m.SwordmasterVariants.Metzger:
						weapon = "scripts/items/weapons/shamshir";
						this.m.Items.equip(::new("scripts/items/shields/oriental/southern_light_shield"));
					break;

				case this.m.SwordmasterVariants.Precise:
					weapon = ::MSU.Class.WeightedContainer([
						[1, "scripts/items/weapons/fencing_sword"],
						[1, "scripts/items/weapons/rf_estoc"]
					]).roll();
					break;

				case this.m.SwordmasterVariants.Reaper:
					weapon = ::MSU.Class.WeightedContainer([
						[1, "scripts/items/weapons/rf_greatsword"],
						[1, "scripts/items/weapons/warbrand"],
						[1, "scripts/items/weapons/greatsword"]
					]).roll();
					break;
			}
				this.m.Items.equip(::new(weapon));
		}
	}

	q.makeMiniboss = @() function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		local r = ::Math.rand(1, 100);
		if (r <= 60) // named weapon
		{
			local weapon = null;
			switch(this.m.MyVariant)
			{
				case this.m.SwordmasterVariants.BladeDancer:
					weapon = ::MSU.Class.WeightedContainer([
						[1, "scripts/items/weapons/named/named_sword"],
						[1, "scripts/items/weapons/named/named_rf_longsword"],
						[1, "scripts/items/weapons/named/named_warbrand"]
					]).roll();
					break;

				case this.m.SwordmasterVariants.Versatile:
						weapon = "scripts/items/weapons/named/named_greatsword";
					break;

				case this.m.SwordmasterVariants.Metzger:
						weapon = "scripts/items/weapons/named/named_shamshir";
						this.m.Items.equip(::new("scripts/items/shields/oriental/southern_light_shield"));
					break;

				case this.m.SwordmasterVariants.Precise:
					weapon = ::MSU.Class.WeightedContainer([
						[1, "scripts/items/weapons/named/named_fencing_sword"],
						[1, "scripts/items/weapons/named/named_rf_estoc"]
					]).roll();
					break;

				case this.m.SwordmasterVariants.Reaper:
					weapon = ::MSU.Class.WeightedContainer([
						[1, "scripts/items/weapons/named/named_warbrand"],
						[1, "scripts/items/weapons/named/named_greatsword"]
					]).roll();
					break;
			}
			this.m.Items.equip(::new(weapon));
		}
		else if (r <= 80) // named armor
		{
			local armor = null;
			if (this.m.MyArmorVariant == 0) // light armor
			{
				armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local stam = ::ItemTables.ItemInfoByScript[_script].StaminaModifier;
						if (stam < -16) return 0.0;
						return _weight;
					}
				})
			}
			else // medium armor
			{
				armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local stam = ::ItemTables.ItemInfoByScript[_script].StaminaModifier;
						if (stam > -26 || stam < -32) return 0.0;
						return _weight;
					}
				})
			}
			if (armor != null) this.m.Items.equip(::new(armor));
		}
		else // named helmet
		{
			local helmet = null;
			if (this.m.MyArmorVariant == 0) // light armor
			{
				helmet = ::Reforged.ItemTable.NamedHelmetNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local stam = ::ItemTables.ItemInfoByScript[_script].StaminaModifier;
						if (stam < -8) return 0.0;
						return _weight;
					}
				})
			}
			else // medium armor
			{
				helmet = ::Reforged.ItemTable.NamedHelmetNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local stam = ::ItemTables.ItemInfoByScript[_script].StaminaModifier;
						if (stam > -10 || stam < -16) return 0.0;
						return _weight;
					}
				})
			}
			if (helmet != null) this.m.Items.equip(::new(helmet));
		}
		return true;
	}

	q.onSpawned = @() function()
	{
		if (this.m.MyArmorVariant == 0) // light armor
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		}
		else // medium armor
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_poise"));
		}

		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			switch(this.m.MyVariant)
			{
				case this.m.SwordmasterVariants.BladeDancer:
					this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordmaster_blade_dancer"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));

					switch (mainhandItem.getID())
					{
						case "weapon.warbrand":
						case "weapon.named_warbrand":
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
							break;
					}
					break;

				case this.m.SwordmasterVariants.Versatile:
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordmaster_versatile_swordsman"));
					break;

				case this.m.SwordmasterVariants.Metzger:
					this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordmaster_metzger"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
					break;

				case this.m.SwordmasterVariants.Precise:
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fencer"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordmaster_precise"));
					break;

				case this.m.SwordmasterVariants.Reaper:
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordmaster_reaper"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
					break;
			}
		}

		if (this.m.IsMiniboss)
		{
			switch(this.m.MyVariant)
			{
				case this.m.SwordmasterVariants.Metzger:
					this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));
					break;

				case this.m.SwordmasterVariants.BladeDancer:
				case this.m.SwordmasterVariants.Versatile:
				case this.m.SwordmasterVariants.Precise:
				case this.m.SwordmasterVariants.Reaper:
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
					break;

			}
		}
	}

	q.onSkillsUpdated = @(__original) function()
	{
		__original();
		if (this.m.MyVariant == this.m.SwordmasterVariants.BladeDancer)
		{
			local weapon = this.getMainhandItem();
			if (weapon != null)
			{
				foreach (skill in weapon.getSkills())
				{
					if (skill.isAOE())
					skill.m.IsUsable = false;
				}
			}
		}
	}
});
