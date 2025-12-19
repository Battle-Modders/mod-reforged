this.rf_draugr_huskarl_bodyguard <- ::inherit("scripts/entity/tactical/enemies/rf_draugr_huskarl", {
	m = {},
	function create()
	{
		this.rf_draugr_huskarl.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_draugr_huskarl_bodyguard";
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_draugr_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}
});
