this.ai_rf_attack_behead <- ::inherit("scripts/ai/tactical/behaviors/ai_attack_default", {
	m = {},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_AttackBehead;
		this.m.Order = ::Const.AI.Behavior.Order.RF_AttackBehead;
		this.m.PossibleSkills = ["actives.exesword_decapitate"];
		this.behavior.create();
	}

	// Default targeting queries the skill's target-specific damage and hitchance:
	// head damage, wound-dependent head chance and the penalty against unimpaired targets.
	// Behead does not use vanilla Decapitate's HP and armor cutoffs.
});
