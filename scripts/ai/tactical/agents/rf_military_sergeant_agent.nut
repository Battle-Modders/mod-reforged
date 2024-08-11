this.rf_military_sergeant_agent <- ::inherit("scripts/ai/tactical/agents/military_melee_agent", {
	m = {},
	function create()
	{
		this.military_melee_agent.create();
		this.m.Properties.PreferCarefulEngage = true;
	}

	function onUpdate()
	{
		this.military_melee_agent.onUpdate();
		this.m.Properties.PreferWait = ::Time.getRound() == 1;
	}
});

