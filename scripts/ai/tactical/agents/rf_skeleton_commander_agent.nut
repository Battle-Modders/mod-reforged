this.rf_skeleton_commander_agent <- ::inherit("scripts/ai/tactical/agents/skeleton_melee_agent", {
	m = {},
	function create()
	{
		this.skeleton_melee_agent.create();
	}

	function onUpdate()
	{
		this.skeleton_melee_agent.create();
		this.m.Properties.OverallFormationMult *= 1.5;
		this.m.Properties.OverallMagnetismMult *= 2.0;
	}
});
