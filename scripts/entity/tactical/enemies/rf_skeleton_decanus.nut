this.rf_skeleton_decanus <- ::inherit("scripts/entity/tactical/rf_skeleton_commander", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_SkeletonDecanus;
		this.m.XP = ::Const.Tactical.Actor.RF_SkeletonDecanus.XP;
		this.m.ResurrectionValue = 7.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_skeleton_decanus";
		this.rf_skeleton_commander.create();
	}

	function onInit()
	{
		this.rf_skeleton_commander.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_SkeletonDecanus);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_decanus"));

		this.getSprite("rf_cape").setBrush("rf_ancient_cape");
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new("scripts/items/weapons/ancient/ancient_sword"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/ancient/tower_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/ancient/ancient_scale_harness"],
				[3, "scripts/items/armor/ancient/ancient_breastplate"]
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
		this.rf_skeleton_commander.onSpawned();
		::Reforged.Skills.addPerkGroup(this, "pg.rf_dagger", 4);
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_tempo"));
	}
});
