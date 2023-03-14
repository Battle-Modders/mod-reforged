this.rf_rebuke_effect <- ::inherit("scripts/skills/skill", {
	m = {
		BaseChance = 25,
		ChanceBonusShield = 10,
		RiposteSkillCounter = 0
	},
	function create()
	{
		this.m.ID = "effects.rf_rebuke";
		this.m.Name = "Rebuke";
		this.m.Description = "This character has a chance to return any missed melee attacks from adjacent attackers with a free attack.";
		this.m.Icon = "ui/perks/rf_rebuke.png";
		this.m.IconMini = "rf_rebuke_effect_mini";
		this.m.Overlay = "rf_rebuke_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::MSU.Text.colorGreen(this.getChance() + "%") + " chance to perform a free attack against characters who miss a melee attack against this character"
		});

		if (this.getContainer().getAttackOfOpportunity() == null)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorRed("Requires a melee attack that exerts [Zone of Control|Concept.ZoneOfControl]"))
			});
		}

		return tooltip;
	}

	function onMissed( _attacker, _skill )
	{
		if (_skill.isRanged() || _skill.isIgnoringRiposte() || !_attacker.isAlive() ||
			_attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1 ||
			::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()) ||
			this.getContainer().getActor().getCurrentProperties().IsRiposting ||
			!this.getContainer().getActor().hasZoneOfControl() ||
			::Math.rand(1, 100) > this.getChance()
		)
			return;

		local info = {
			Skill = this.getContainer().getAttackOfOpportunity(), // we know it won't be null because we do a hasZoneOfControl check earlier
			TargetTile = _attacker.getTile()
		};
		::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.onRiposte.bindenv(this), info);
	}

	function getChance()
	{
		local chanceBonus = this.getContainer().getActor().isArmedWithShield() ? this.m.ChanceBonusShield : 0;
		return this.m.BaseChance + chanceBonus;
	}

	function onRiposte( _info )
	{
		if (!this.getContainer().getActor().isAlive() || this.m.RiposteSkillCounter == ::Const.SkillCounter)
			return;

		this.m.RiposteSkillCounter = ::Const.SkillCounter;
		_info.Skill.useForFree(_info.TargetTile);
	}
});
