this.rf_skeleton_medium_elite <- ::inherit("scripts/entity/tactical/skeleton", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_SkeletonMediumElite;
		this.m.XP = ::Const.Tactical.Actor.RF_SkeletonMediumElite.XP;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_skeleton_medium_elite";
		this.skeleton.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/skeleton_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_SkeletonMediumElite);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
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
				[1, "scripts/items/armor/ancient/ancient_scale_coat"],
				[1, "scripts/items/armor/ancient/ancient_plated_mail_hauberk"]
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
		this.skeleton.onSetupEntity();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}
});
