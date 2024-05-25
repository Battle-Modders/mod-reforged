this.rf_poise_effect <- ::inherit("scripts/skills/skill", {
	m = {
		// Config
		HeadshotMult = 1.5,	// multiplier for incoming poise damage on a hit to the head (unless steelbrow was learned)
	},

	function create()
	{
		this.m.ID = "effects.poise";
		this.m.Name = "Poise";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Certain skills, like [stunning attacks|Concept.StunningAttack], damage your [Poise|Concept.Poise] and apply an effect when they reduce it to 0 or below. If that happens or at the start of your turn your Poise is reset back to your maximum Poise.");
		this.m.Icon = "ui/traits/trait_icon_15.png";	// Placeholder - TODO: create unique icon instead of usin
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = false;
	}

	function getName()
	{
		if (::MSU.isNull(this.getContainer())) return this.m.Name;

		local actor = this.getContainer().getActor();
		local properties = actor.getCurrentProperties();
		local suffix = properties.IsImmuneToStunFromPoise ? " (Immune)" : " (" + actor.getPoise() + " / " + properties.getPoiseMax() + ")";

		return this.m.Name + suffix;
	}

	function onTurnStart()
	{
		this.getContainer().getActor().resetPoise();
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null || !_skill.m.IsDamagingPoise) return;

		local attackPower = this.__calculatePoiseDamage(_attacker, _skill, _hitInfo.BodyPart == ::Const.BodyPart.Head);
		if (attackPower == 0) return;

		this.onPoiseDamageReceived(_attacker, _skill, attackPower, true, _properties);
	}

// New Functions
	// Is called automatically when receiving attacks which damage poise
	// Can be called manually from the outside, e.g. by charge skills that do not use attacks
	// Returns the amount of turns that the target was stunned, so it can be used to additionally apply other effects/behaviors when called manually
	function onPoiseDamageReceived( _attacker, _skill, _attackPower, _printLog = true, _properties = null )
	{
		local actor = this.getContainer().getActor();
		actor.addPoise(-1 * _attackPower);

		local turnsStunned = 0;
		if (_skill != null && _skill.m.IsStunningFromPoise)
		{
			if (_properties == null) _properties = actor.getCurrentProperties();

			turnsStunned = this.__calculateTurnsStunned(_properties.getPoiseMax());
			if (turnsStunned == 0) return 0;

			local stunnedEffect = this.getContainer().getSkillByID("effects.stunned");
			if (stunnedEffect == null)
			{
				stunnedEffect = ::new("scripts/skills/effects/stunned_effect");
				this.getContainer().add(stunnedEffect);
			}

			stunnedEffect.setTurns(turnsStunned);
			if (_printLog)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_attacker) + " has stunned " + ::Const.UI.getColorizedEntityName(actor) + " for " + ::MSU.Text.colorGreen(turnsStunned) + " turn");
			}

			this.getContainer().getActor().resetPoise();
		}

		return turnsStunned;
	}

	// Returns amount of turns that a target would be stunned. Is used for tooltips predicting this
	function wouldStun( _attacker, _skill, _bodyPart)
	{
		local poiseDamage = this.__calculatePoiseDamage(_attacker, _skill, _bodyPart);
		if (poiseDamage == 0) return 0;

		local myProperties = this.getContainer().buildPropertiesForDefense(_attacker, _skill);
		return this.__calculateTurnsStunned(myProperties.getPoiseMax(), poiseDamage);
	}

	// Returns, for how long we are being stunned right now (1 parameter) or would be, if given a simulated attack power
	function __calculateTurnsStunned( _PoiseMax, _simulatedAttackPower = 0 )	// _simulatedAttackPower is only used here when simulating whether something would stun
	{
		local actor = this.getContainer().getActor();
		if (actor.getPoise() - _simulatedAttackPower > 0) return 0;
		if (actor.getPoise() - _simulatedAttackPower > -1 * _PoiseMax) return 1;
		return 2;
	}

	function __calculatePoiseDamage( _attacker, _skill, _bodyPart)
	{
		if (!_skill.m.IsDamagingPoise) return 0;

		local poiseDamage = _attacker.getSkills().buildPropertiesForUse(_skill, null).getPoiseDamage();
		if (poiseDamage == 0) return;

		if (_bodyPart == ::Const.BodyPart.Head && !this.getContainer().hasSkill("perk.steel_brow"))
		{
			poiseDamage *= this.m.HeadshotMult;
		}
		poiseDamage = ::Math.floor(poiseDamage);

		return poiseDamage;
	}
});
