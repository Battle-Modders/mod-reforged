this.rf_draugr_warrior_bodyguard <- ::inherit("scripts/entity/tactical/enemies/rf_draugr_warrior", {
	m = {},
	function create()
	{
		this.rf_draugr_warrior.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_draugr_warrior_bodyguard";
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/zombie_agent");
		this.m.AIAgent.setActor(this);
	}
});
