this.ai_rf_attack_skewer <- ::inherit("scripts/ai/tactical/behaviors/ai_attack_default", {
	// Solely for applying the behavior to proper agents. 
	// Damage can be auto calculated.
	m = {},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_AttackSkewer;
		this.m.Order = ::Const.AI.Behavior.Order.RF_AttackSkewer;
		this.m.PossibleSkills = ["actives.skewer"];
		this.behavior.create();
	}
});
