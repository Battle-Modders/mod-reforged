::mods_hookExactClass("entity/tactical/enemies/bandit_raider", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditRaider);
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

		// if (!this.m.IsLow)
		// {
		// 	b.IsSpecializedInSwords = true;
		// 	b.IsSpecializedInAxes = true;
		// 	b.IsSpecializedInMaces = true;
		// 	b.IsSpecializedInFlails = true;
		// 	b.IsSpecializedInPolearms = true;
		// 	b.IsSpecializedInThrowing = true;
		// 	b.IsSpecializedInHammers = true;
		// 	b.IsSpecializedInSpears = true;
		// 	b.IsSpecializedInCleavers = true;

		// 	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		// 	{
		// 		b.MeleeSkill += 5;
		// 		b.RangedSkill += 5;
		// 	}
		// }

		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); //Replaced with perk

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_momentum"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;

		if (this.Math.rand(1, 100) <= 20)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(0, 11);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
				}

				//Reforged
				else if (r == 9)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/rf_battle_axe"));
				}
				else if (r == 10)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/rf_greatsword"));
				}
				else if (r == 11)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/rf_reinforced_wooden_poleflail"));
				}

			}
			else
			{
				r = this.Math.rand(0, 4);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
				}
			}
		}
		else
		{
			r = this.Math.rand(2, 10);

			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/flail"));
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35)
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

		r = this.Math.rand(2, 7);
		local armor;

		if (r == 2)
		{
			armor = this.new("scripts/items/armor/ragged_surcoat");
		}
		else if (r == 3)
		{
			armor = this.new("scripts/items/armor/padded_leather");
		}
		else if (r == 4)
		{
			armor = this.new("scripts/items/armor/worn_mail_shirt");
		}
		else if (r == 5)
		{
			armor = this.new("scripts/items/armor/patched_mail_shirt");
		}
		else if (r == 6)
		{
			armor = this.new("scripts/items/armor/worn_mail_shirt");
		}
		else if (r == 7)
		{
			armor = this.new("scripts/items/armor/patched_mail_shirt");
		}

		this.m.Items.equip(armor);

		if (this.Math.rand(1, 100) <= 85)
		{
			local r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
		}

		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	    if (::Reforged.Config.IsLegendaryDifficulty)
		{
			if (this.isArmedWithShield())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_line_breaker"));
			}
			else
			{
				if (this.getOffhandItem() == null)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
				}
				else
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_vigorous_assault"));
				}
			}
		}

	}
});
