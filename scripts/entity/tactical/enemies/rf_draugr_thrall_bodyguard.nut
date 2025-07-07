this.rf_draugr_thrall_bodyguard <- ::inherit("scripts/entity/tactical/enemies/rf_draugr_thrall", {
	m = {},
	function create()
	{
		this.rf_draugr_thrall.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_draugr_thrall_bodyguard";
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/zombie_agent");
		this.m.AIAgent.setActor(this);
	}

	function assignRandomEquipment()
	{
	  this.rf_draugr_thrall.assignRandomEquipment();

	  if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
	  {
	  	this.m.Items.equip(::new("scripts/items/shields/rf_draugr/rf_draugr_round_shield"));
	  }
	}
});
