// Ancient Miles
this.rf_skeleton_light_elite_polearm <- ::inherit("scripts/entity/tactical/enemies/rf_skeleton_light_elite", {
	m = {},
	function create()
	{
		this.rf_skeleton_light_elite.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_skeleton_light_elite_polearm";
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

		b.Initiative -= 20;

		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[2, "scripts/items/weapons/ancient/broken_bladed_pike"],
				[1, "scripts/items/weapons/ancient/bladed_pike"],
			]).roll();
			this.m.Items.equip(::new(weapon));
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
});
