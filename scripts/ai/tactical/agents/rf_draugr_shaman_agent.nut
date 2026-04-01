this.rf_draugr_shaman_agent <- ::inherit("scripts/ai/tactical/agents/necromancer_agent", {
	m = {},
	function create()
	{
		this.necromancer_agent.create();
	}

	function onAddBehaviors()
	{
		this.necromancer_agent.onAddBehaviors();
		this.removeBehavior(::Const.AI.Behavior.ID.Flee);
	}
});
