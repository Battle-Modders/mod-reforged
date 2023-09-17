this.rf_bandit_leader_agent <- this.inherit("scripts/ai/tactical/agents/bandit_melee_agent", {
	m = {},
	function create()
	{
		this.bandit_melee_agent.create();
		this.m.Properties.OverallFormationMult *= 1.2;
		this.m.Properties.OverallMagnetismMult *= 1.5;
	}
});

