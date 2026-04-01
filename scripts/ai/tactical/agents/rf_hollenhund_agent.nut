this.rf_hollenhund_agent <- ::inherit("scripts/ai/tactical/agents/ghoul_agent", {
	m = {},
	function create()
	{
		this.ghoul_agent.create();
		this.m.Properties.EngageFlankingMult = 2.0;
	}

	function onAddBehaviors()
	{
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_roam"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_default"));
	}
});
