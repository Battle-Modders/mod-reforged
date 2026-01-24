// Ancient Honor Guard
this.rf_skeleton_heavy_elite <- ::inherit("scripts/entity/tactical/skeleton", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_SkeletonHeavyElite;
		this.m.XP = ::Const.Tactical.Actor.RF_SkeletonHeavyElite.XP;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_skeleton_heavy_elite";
		this.skeleton.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/skeleton_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_SkeletonHeavyElite);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_calculated_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/ancient/khopesh"],
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

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = ::Const.Items.NamedUndeadWeapons;
		this.m.Items.equip(::new("scripts/items/" + weapons[::Math.rand(0, weapons.len() - 1)]));

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		return true;
	}

	function onSpawned()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
		}

		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isAoE())
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
			}
			if (weapon.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}
	}
});
