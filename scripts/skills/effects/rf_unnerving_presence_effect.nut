this.rf_unnerving_presence_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_unnerving_presence";
		this.m.Name = "Unnerving Presence";
		this.m.Description = "This character has an aura of intense dread around him that gnaws at the sanity of those who dare come close.";
		this.m.Icon = "skills/rf_unnerving_presence_effect.png";
		this.m.Overlay = "rf_unnerving_presence_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString("Characters ending their [turn|Concept.Turn] adjacent to you receive a mental [morale check|Concept.Morale]")
		});

		return ret;
	}

	function onActorSpawned( _actor )
	{
		if (!::MSU.isKindOf(_actor, "rf_draugr") && !_actor.getSkills().hasSkill("special.rf_unnerving_presence_manager"))
		{
			_actor.getSkills().add(::new("scripts/skills/special/rf_unnerving_presence_manager"));
		}
	}

	function onEnemyTurnEnd( _enemy )
	{
		if (_enemy.getMoraleState() == ::Const.MoraleState.Ignore)
			return;

		_enemy.checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack, this.m.Overlay);
	}
});
