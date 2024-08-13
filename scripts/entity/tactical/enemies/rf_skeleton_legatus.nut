this.rf_skeleton_legatus <- ::inherit("scripts/entity/tactical/rf_skeleton_commander", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_SkeletonLegatus;
		this.m.XP = ::Const.Tactical.Actor.RF_SkeletonLegatus.XP;
		this.m.ResurrectionValue = 13.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_skeleton_legatus";
		this.rf_skeleton_commander.create();
	}

	function onInit()
	{
		this.rf_skeleton_commander.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_SkeletonLegatus);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_decisive"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigilant"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_legatus"));

		this.getSprite("rf_cape").setBrush("rf_ancient_cape");
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new("scripts/items/weapons/ancient/crypt_cleaver"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/ancient/ancient_plate_harness"],
				[1, "scripts/items/armor/ancient/ancient_plated_scale_hauberk"]
			]).roll();
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new("scripts/items/helmets/ancient/ancient_legionary_helmet"));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/named/named_bladed_pike"],
				[1, "scripts/items/weapons/named/named_warscythe"]
			]).roll();
			this.m.Items.equip(::new(weapon));
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_inspiring_presence"));
		return true;
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		}
	}
});
