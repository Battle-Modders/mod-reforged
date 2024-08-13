this.rf_military_fencer_agent <- ::inherit("scripts/ai/tactical/agents/military_melee_agent", {
	m = {},
	function create()
	{
		this.military_melee_agent.create();

		this.m.Properties.EngageFlankingMult *= 2.0;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult *= 1.2;
		this.m.Properties.OverallMagnetismMult *= 0.5;

		this.m.Properties.PreferWait = true;
		this.m.Properties.PreferCarefulEngage = true;
	}

	function onAddBehaviors()
	{
		this.military_melee_agent.onAddBehaviors();
		this.removeBehavior(::Const.AI.Behavior.ID.Protect);
	}

	function onUpdate()
	{
		this.military_melee_agent.onUpdate();

		this.m.Properties.OverallFormationMult = 0.25;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.5; // Greater than 1 means less likely to engage multiple opponents
	}
});
