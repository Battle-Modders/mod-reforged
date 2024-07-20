this.rf_bandit_tough_agent <- ::inherit("scripts/ai/tactical/agents/bandit_melee_agent", {
	m = {},
	function create()
	{
		this.bandit_melee_agent.create();

		this.m.Properties.TargetPriorityCounterSkillsMult *= 1.5;	// Higher chance to attack into CounterSkills compared to normal bandits

		this.m.Properties.EngageFlankingMult *= 0.5;			// Has almost no intention of flanking the enemy
		this.m.Properties.OverallDefensivenessMult *= 0.8;		// Is more likely to be the first one charging into the enemies
		this.m.Properties.OverallFormationMult *= 0.8;			// Does not care as much about maintaining formation
		this.m.Properties.EngageAgainstSpearwallMult *= 0.8;	// Runs more often head on into Spearwalls
	}
});
