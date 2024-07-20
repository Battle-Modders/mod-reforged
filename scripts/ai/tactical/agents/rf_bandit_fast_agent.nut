this.rf_bandit_fast_agent <- ::inherit("scripts/ai/tactical/agents/bandit_melee_agent", {
	m = {},
	function create()
	{
		this.bandit_melee_agent.create();

		this.m.Properties.EngageFlankingMult *= 2.0;
		this.m.Properties.TargetPriorityFleeingMult *= 1.5;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult *= 1.2;

		this.m.Properties.OverallFormationMult *= 0.8;
		this.m.Properties.OverallMagnetismMult *= 0.9;

		this.m.Properties.PreferWait = true;
		this.m.Properties.PreferCarefulEngage = true;
	}
});

