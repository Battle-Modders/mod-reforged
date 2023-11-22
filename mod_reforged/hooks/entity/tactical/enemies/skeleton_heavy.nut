::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_heavy", function(q) {
	q.onInit = @() function()
	{
	   	this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonHeavy);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		// {
		// 	b.IsSpecializedInPolearms = true;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_devastating_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
	}

	q.assignRandomEquipment = @() function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/ancient/ancient_sword"],
	    		[1, "scripts/items/weapons/ancient/khopesh"],
	    		[1, "scripts/items/weapons/ancient/warscythe"],
	    		[1, "scripts/items/weapons/ancient/crypt_cleaver"],
	    		[1, "scripts/items/weapons/ancient/rhomphaia"]
	    	]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/ancient/tower_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1.0, "scripts/items/armor/ancient/ancient_plate_harness"],
				[1.0, "scripts/items/armor/ancient/ancient_plated_scale_hauberk"]
			]).roll();

			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new("scripts/items/helmets/ancient/ancient_honorguard_helmet"));
		}
	}

	q.makeMiniboss = @() function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = this.Const.Items.NamedUndeadWeapons;
		this.m.Items.equip(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_intimidate", function(o) {
			o.m.IsForceEnabled = true;
		}));
		return true;
	}

	q.onSetupEntity <- function()
	{
		local weapon = this.getMainhandItem();
		if (weapon == null) return;

		if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));

			if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_en_garde"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_kata"));
			}
		}
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_cleaver"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		}
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Polearm))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		}
	}
});
