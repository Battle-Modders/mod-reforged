this.rf_rebuke_effect <- ::inherit("scripts/skills/skill", {
	m = {
		BaseChance = 25,
		ChanceBonusShield = 15,
		BuildsFatigue = true,
		RiposteSkillCounter = 0
	},
	function create()
	{
		this.m.ID = "effects.rf_rebuke";
		this.m.Name = "Rebuke";
		this.m.Description = "This character has a chance to return any missed melee attacks from adjacent attackers with a free attack.";
		this.m.Icon = "ui/perks/perk_rf_rebuke.png";
		this.m.IconMini = "rf_rebuke_effect_mini";
		this.m.Overlay = "rf_rebuke_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::MSU.Text.colorPositive(this.getChance() + "%") + " chance to perform a free attack against characters who miss a melee attack against this character"
		});

		if (this.getContainer().getAttackOfOpportunity() == null)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Requires a melee attack that exerts [Zone of Control|Concept.ZoneOfControl]"))
			});
		}

		return ret;
	}

	function canProc( _attacker, _skill )
	{
		if (_skill.isRanged() || _skill.isIgnoringRiposte() || !_attacker.isAlive())
			return false;

		local actor = this.getContainer().getActor();
		local hookedShield = actor.getSkills().getSkillByID("effects.rf_hooked_shield_effect");
		if (hookedShield != null && !hookedShield.isHidden())
			return false;

		if (_attacker.getTile().getDistanceTo(actor.getTile()) > 1 || ::Tactical.TurnSequenceBar.isActiveEntity(actor) || actor.getCurrentProperties().IsRiposting || !actor.hasZoneOfControl())
		{
			return false;
		}

		if (this.m.BuildsFatigue && !actor.isArmedWithShield() && actor.getFatigueMax() - actor.getFatigue() < this.getContainer().getAttackOfOpportunity().getFatigueCost())
		{
			return false;
		}

		return true;
	}

	function onMissed( _attacker, _skill )
	{
		if (!this.canProc(_attacker, _skill) || ::Math.rand(1, 100) > this.getChance())
			return;

		local info = {
			User = this.getContainer().getActor(),
			Skill = this.getContainer().getAttackOfOpportunity(), // we know it won't be null because we do a hasZoneOfControl check in canProc
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

		if (!_info.User.getTile().hasLineOfSightTo(_info.TargetTile, _info.User.getCurrentProperties().getVision()))
			return;

		if (!_info.Skill.verifyTargetAndRange(_info.TargetTile, _info.User.getTile()))
			return;

		this.m.RiposteSkillCounter = ::Const.SkillCounter;
		if (this.m.BuildsFatigue && !_info.User.isArmedWithShield() && !_info.User.checkMorale(0, 0))
			_info.User.setFatigue(::Math.min(_info.User.getFatigueMax(), _info.User.getFatigue() + _info.Skill.getFatigueCost()));

		_info.Skill.useForFree(_info.TargetTile);
	}
});
