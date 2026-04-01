this.rf_draugr_bodyguard_agent <- ::inherit("scripts/ai/tactical/agents/rf_draugr_agent", {
	m = {},
	function create()
	{
		this.rf_draugr_agent.create();
		this.m.ID = ::Const.AI.Agent.ID.RF_DraugrBodyguard;
		this.m.Properties.IgnoreTargetValueOnEngage = true;
	}

	function onAddBehaviors()
	{
		this.rf_draugr_agent.onAddBehaviors();
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_protect"));
	}
});
