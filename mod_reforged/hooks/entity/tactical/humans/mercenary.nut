::Reforged.HooksMod.hook("scripts/entity/tactical/humans/mercenary", function(q) {
	q.onInit = @(__original) function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Mercenary);
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
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		b.RangedDefense += 10;
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
    	}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    local r;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/billhook",
				"weapons/pike",
				"weapons/warbrand",
				"weapons/longsword",
				"weapons/hand_axe",
				"weapons/fighting_spear",
				"weapons/morning_star",
				"weapons/falchion",
				"weapons/arming_sword",
				"weapons/flail",
				"weapons/military_pick"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/polehammer",
					"weapons/three_headed_flail"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/bardiche",
					"weapons/scimitar"
				]);
			}

			// Reforged
			weapons.extend([
				"weapons/rf_kriegsmesser",
				"weapons/rf_greatsword"
			]);

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				r = this.Math.rand(0, 2);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 60)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
				else if (r == 3)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
				}
			}
			else
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
			}
		}

		if (this.Const.DLC.Unhold)
		{
			r = this.Math.rand(1, 11);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/sellsword_armor"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/armor/lamellar_harness"));
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/armor/footman_armor"));
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/armor/light_scale_armor"));
			}
			else if (r == 11)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_scale_armor"));
			}
		}
		else
		{
			r = this.Math.rand(2, 8);

			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/armor/lamellar_harness"));
			}
		}

		if (this.Math.rand(1, 100) <= 95)
		{
			local helmets = [
				"scripts/items/helmets/nasal_helmet",
				"scripts/items/helmets/nasal_helmet_with_mail",
				"scripts/items/helmets/mail_coif",
				"scripts/items/helmets/reinforced_mail_coif",
				"scripts/items/helmets/headscarf",
				"scripts/items/helmets/kettle_hat",
				"scripts/items/helmets/kettle_hat_with_mail",
				"scripts/items/helmets/flat_top_helmet",
				"scripts/items/helmets/flat_top_with_mail",
				"scripts/items/helmets/closed_flat_top_helmet",
				"scripts/items/helmets/closed_mail_coif",
				"scripts/items/helmets/bascinet_with_mail"
			];

			if (this.Const.DLC.Wildmen)
			{
				helmets.extend([
					"scripts/items/helmets/nordic_helmet",
					"scripts/items/helmets/steppe_helmet_with_mail"
				]);
			}

			this.m.Items.equip(this.new(helmets[this.Math.rand(1, helmets.len() - 1)]));
		}

	    if (::Reforged.Config.IsLegendaryDifficulty)
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 7);
	    }
	    else
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 6);
	    }

	    if (this.isArmedWithShield())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	    }

	    local aoo = this.m.Skills.getAttackOfOpportunity();
	    if (aoo != null && aoo.isDuelistValid())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
	    }
	    else
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
	    }

	    foreach (item in this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag))
	    {
	    	if (item.isItemType(::Const.Items.ItemType.RangedWeapon) && item.isWeaponType(::Const.Items.WeaponType.Throwing))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_proximity_throwing_specialist"));
	    		if (::Reforged.Config.IsLegendaryDifficulty)
			    {
			    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_opportunist"));
			    }
	    		break;
	    	}
	    }
	}
});
