::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/orc_young", function(q) {
	q.onInit = @() { function onInit()
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
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Bag) && ::Math.rand(1, 100) <= 25)
		{
			this.m.Items.addToBag(::new("scripts/items/weapons/greenskins/orc_javelin"));
		}

		local weapon = ::MSU.Class.WeightedContainer([
			[1, "scripts/items/weapons/greenskins/orc_axe"],
			[1, "scripts/items/weapons/greenskins/orc_cleaver"],
			[1, "scripts/items/weapons/greenskins/orc_wooden_club"],
			[1, "scripts/items/weapons/greenskins/orc_metal_club"],
			// The sum of the weight of the following weapons should be 1/4 of the total weight.
			// Because in vanilla Orc Young have a 75% chance to spawn with one of the above weapons.
			// [0.33, "scripts/items/weapons/greenskins/goblin_falchion"], // Disabled in Reforged on Orc Young
			[0.67, "scripts/items/weapons/hatchet"],
			[0.67, "scripts/items/weapons/morning_star"]
		]).roll();

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new(weapon));
		}
		else
		{
			this.m.Items.addToBag(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand) && ::Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(::new("scripts/items/shields/greenskins/orc_light_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/greenskins/orc_young_very_light_armor"],
				[1, "scripts/items/armor/greenskins/orc_young_light_armor"],
				[1, "scripts/items/armor/greenskins/orc_young_medium_armor"],
				[1, "scripts/items/armor/greenskins/orc_young_heavy_armor"],
				[1, "NoArmor"]
			]).roll();

			if (armor != "NoArmor")
			{
				this.m.Items.equip(::new(armor));
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/greenskins/orc_young_light_helmet"],
				[1, "scripts/items/helmets/greenskins/orc_young_medium_helmet"],
				[1, "scripts/items/helmets/greenskins/orc_young_heavy_helmet"],
				[1, "NoHelmet"]
			]).roll();

			if (helmet != "NoHelmet")
			{
				this.m.Items.equip(::new(helmet));
			}
		}
	}}.assignRandomEquipment;

	q.onSpawned = @() { function onSpawned()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);
	}}.onSpawned;
});
