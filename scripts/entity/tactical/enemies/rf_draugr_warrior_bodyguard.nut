this.rf_draugr_warrior_bodyguard <- ::inherit("scripts/entity/tactical/enemies/rf_draugr_warrior", {
	m = {},
	function create()
	{
		this.rf_draugr_warrior.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_draugr_warrior_bodyguard";
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_draugr_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/rf_draugr/rf_draugr_round_shield"));
		}

		this.rf_draugr_warrior.assignRandomEquipment();
	}
});
