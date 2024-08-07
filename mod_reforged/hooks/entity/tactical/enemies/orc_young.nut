::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/orc_young", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.OrcYoung);

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 70)
		// {
		// 	b.IsSpecializedInThrowing = true;

		// 	if (::World.getTime().Days >= 150)
		// 	{
		// 		b.RangedSkill += 5;
		// 	}
		// }

		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_01_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_01_body");
		body.varySaturation(0.05);
		body.varyColor(0.07, 0.07, 0.07);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_01_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_01_head_0" + ::Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_01_head_injured");
		this.addSprite("helmet");
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_01_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.m.Skills.add(::new("scripts/skills/special/double_grip"));
		this.m.Skills.add(::new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(::new("scripts/skills/actives/charge"));

		if (::Const.DLC.Unhold)
		{
			this.m.Skills.add(::new("scripts/skills/actives/wake_ally_skill"));
		}

		this.m.Skills.add(::new("scripts/skills/effects/captain_effect"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Orc;
		this.m.Skills.add(::new("scripts/skills/racial/rf_orc_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
	}

	q.assignRandomEquipment = @() function()
	{
		local r;
		local weapon;

		if (::Math.rand(1, 100) <= 25)
		{
			this.m.Items.addToBag(::new("scripts/items/weapons/greenskins/orc_javelin"));
		}

		if (::Math.rand(1, 100) <= 75)
		{
			if (::Math.rand(1, 100) <= 50)
			{
				local r = ::Math.rand(1, 2);

				if (r == 1)
				{
					weapon = ::new("scripts/items/weapons/greenskins/orc_axe");
				}
				else if (r == 2)
				{
					weapon = ::new("scripts/items/weapons/greenskins/orc_cleaver");
				}
			}
			else
			{
				local r = ::Math.rand(1, 2);

				if (r == 1)
				{
					weapon = ::new("scripts/items/weapons/greenskins/orc_wooden_club");
				}
				else if (r == 2)
				{
					weapon = ::new("scripts/items/weapons/greenskins/orc_metal_club");
				}
			}
		}
		else
		{
			r = ::Math.rand(1, 2);

			// if (r == 1)
			// {
			// 	weapon = ::new("scripts/items/weapons/greenskins/goblin_falchion");
			// }
			if (r == 1)
			{
				weapon = ::new("scripts/items/weapons/hatchet");
			}
			else
			{
				weapon = ::new("scripts/items/weapons/morning_star");
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(weapon);
		}
		else
		{
			this.m.Items.addToBag(weapon);
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(::new("scripts/items/shields/greenskins/orc_light_shield"));
		}

		r = ::Math.rand(1, 5);

		if (r == 1)
		{
			this.m.Items.equip(::new("scripts/items/armor/greenskins/orc_young_very_light_armor"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(::new("scripts/items/armor/greenskins/orc_young_light_armor"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(::new("scripts/items/armor/greenskins/orc_young_medium_armor"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(::new("scripts/items/armor/greenskins/orc_young_heavy_armor"));
		}

		r = ::Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(::new("scripts/items/helmets/greenskins/orc_young_light_helmet"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(::new("scripts/items/helmets/greenskins/orc_young_medium_helmet"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(::new("scripts/items/helmets/greenskins/orc_young_heavy_helmet"));
		}
	}

	q.onSetupEntity = @() function()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);
	}
});
