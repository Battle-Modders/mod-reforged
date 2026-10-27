this.rf_beckoned_player_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.Properties.OverallMagnetismMult = 0.1;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_rf_beckoned_move"));
	}

	function onUpdate()
	{
	}

});

