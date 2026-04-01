this.rf_zombie_orc_young_bodyguard <- ::inherit("scripts/entity/tactical/enemies/rf_zombie_orc_young", {
	m = {},
	function create()
	{
		this.rf_zombie_orc_young.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_zombie_orc_young_bodyguard";
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/zombie_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.rf_zombie_orc_young.onInit();
		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	}

	function assignRandomEquipment()
	{
		this.rf_zombie_orc_young.assignRandomEquipment();
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/greenskins/orc_light_shield.nut"));
		}
	}
});
