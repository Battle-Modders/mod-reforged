this.rf_skeleton_centurion <- ::inherit("scripts/entity/tactical/rf_skeleton_commander", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_SkeletonCenturion;
		this.m.XP = ::Const.Tactical.Actor.RF_SkeletonCenturion.XP;
		this.m.ResurrectionValue = 10.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_skeleton_centurion";
		this.rf_skeleton_commander.create();
	}

	function onInit()
	{
		this.rf_skeleton_commander.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_SkeletonCenturion);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_combo"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_centurion"));

		this.getSprite("rf_cape").setBrush("rf_ancient_cape");
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/weapons/ancient/rhomphaia"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[2, "scripts/items/armor/ancient/ancient_plated_mail_hauberk"],
				[3, "scripts/items/armor/ancient/ancient_scale_coat"]
			]).roll();
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new("scripts/items/helmets/ancient/ancient_legionary_helmet"));
		}
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		}
	}
});
