::Reforged.HooksMod.hook("scripts/entity/tactical/humans/desert_devil", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.DesertDevil);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
		// this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_head_hunter"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(::new("scripts/skills/effects/dodge_effect"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(::new("scripts/skills/actives/adrenaline_skill"));
		// this.m.Skills.add(::new("scripts/skills/actives/footwork"));
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		//Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_kata", function(o) {
			o.m.RequiredDamageType = null;
			o.m.RequiredWeaponType = null;
			o.m.RequireOffhandFree = false;
		}));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
	}

	q.assignRandomEquipment = @() function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[2, "scripts/items/weapons/shamshir"],

				[1, "scripts/items/weapons/oriental/swordlance"],
				[1, "scripts/items/weapons/rf_voulge"]
			]).roll();
			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/oriental/southern_light_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/oriental/assassin_robe"],
				[1, "scripts/items/armor/leather_scale_armor"]
			]).roll();
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new("scripts/items/helmets/oriental/blade_dancer_head_wrap"));
		}
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.BaseProperties.DamageDirectMult *= 0.8; //Reverts 1.25 bonus from vanilla

			local mainhandItem = this.getMainhandItem();
			if (mainhandItem != null)
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Cleaver))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Polearm))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordmaster_blade_dancer"));
				}
			}
		}

		return ret;
	}

	q.onSpawned = @() function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Cleaver))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_calculated_strikes"));
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Polearm))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4)
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
		}
	}
});
