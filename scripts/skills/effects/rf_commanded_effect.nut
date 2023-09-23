this.rf_commanded_effect <- ::inherit("scripts/skills/skill", {
	m = {},

	function create()
	{
		this.m.ID = "effects.rf_commanded";
		this.m.Name = "Commanded by an ally";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsHidden = true;
	}

	function onNewRound()
	{
		this.removeSelf();
	}
});
