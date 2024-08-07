// Ancient Miles
this.rf_skeleton_light_elite <- ::inherit("scripts/entity/tactical/skeleton", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_SkeletonLightElite;
		this.m.XP = ::Const.Tactical.Actor.RF_SkeletonLightElite.XP;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_skeleton_light_elite";
		this.skeleton.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/skeleton_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_SkeletonLightElite);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/ancient/broken_ancient_sword"],
				[1, "scripts/items/weapons/ancient/falx"],
				[2, "scripts/items/weapons/ancient/ancient_spear"]
			]).roll();
			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/ancient/auxiliary_shield"],
				[2, "scripts/items/shields/ancient/coffin_shield"]
			]).roll();
			this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/ancient/ancient_mail"],
				[1, "scripts/items/armor/ancient/ancient_double_layer_mail"]
			]).roll();
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new("scripts/items/helmets/ancient/ancient_household_helmet"));
		}
	}

	function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				this.m.Skills.removeByID("actives.rf_kata_step_skill");
			}
		}
	}
});
