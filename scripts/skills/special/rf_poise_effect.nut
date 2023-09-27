/*
Internally we calculate the current threshold inversely. That makes it much cleaner in code to handle increases and reduction of PoiseMax.
Our intended behavior is that a change in PoiseMax also changes the Poise of that character by the same amount:

The PoiseMax is purely handled in the Properties while the current Poise is handled in this skill.
It is much cleaner when a change to PoiseMax can solely focus on changing variables in Properties.
*/

this.rf_poise_effect <- ::inherit("scripts/skills/skill", {
	m = {
		// Config
		HeadshotMult = 1.5,	// multiplier for incoming poise damage on a hit to the head (unless steelbrow was learned)

		// Private
		InversePoise = 0,	// This is the inverse of Poise and counts upwards instead of downwards as Poise damaged is received
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

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		return tooltip;
	}

	function getName()
	{
		if (::MSU.isNull(this.getContainer())) return this.m.Name;

		local properties = this.getContainer().getActor().getCurrentProperties();
		local suffix = properties.IsImmuneToStunFromPoise ? " (Immune)" : " (" + this.getPoise(properties) + " / " + properties.getPoiseMax() + ")";

		return this.m.Name + suffix;
	}

	function onTurnStart()
	{
		this.resetPoise();
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null || !_skill.m.IsDamagingPoise) return;

		local attackPower = this.calculatePoiseDamage(_attacker, _skill, _hitInfo.BodyPart == ::Const.BodyPart.Head);
		if (attackPower == 0) return;

		this.onPoiseDamageReceived(_attacker, _skill, attackPower, true, _properties);
	}

// New Functions
	function getPoise( _properties = null )
	{
		if (_properties == null) _properties = this.getContainer().getActor().getCurrentProperties();

		return _properties.getPoiseMax() - this.m.InversePoise;
	}

	function resetPoise()
	{
		this.m.InversePoise = 0;
	}

	// Can be called manually from the outside, e.g. by charge skills that do not use attacks
	// Returns the amount of turns that the target was stunned. Can be used to apply other effects/behaviors when called manually
	function onPoiseDamageReceived( _attacker, _skill, _attackPower, _printLog = true, _properties = null )
	{
		this.m.InversePoise += _attackPower;

		local turnsStunned = 0;
		if (_skill.m.IsStunningFromPoise)
		{
			if (_properties == null) _properties = this.getContainer().getActor().getCurrentProperties();

			turnsStunned = this.calculateTurnsStunned(_properties.getPoiseMax());
			if (turnsStunned == 0) return;

			local stunnedEffect = this.getContainer().getSkillByID("effects.stunned");
			if (stunnedEffect == null)
			{
				stunnedEffect = ::new("scripts/skills/effects/stunned_effect");
				this.getContainer().add(stunnedEffect);
			}

			stunnedEffect.setTurns(turnsStunned);
			if (_printLog)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_attacker) + " has stunned " + ::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " for " + ::MSU.Text.colorGreen(turnsStunned) + " turn");
			}

			this.resetPoise();
		}

		return turnsStunned;
	}

	// Returns, for how long we are being stunned right now (1 parameter) or would be, if given a simulated attack power
	function calculateTurnsStunned( _PoiseMax, _simulatedAttackPower = 0 )	// _simulatedAttackPower is only used here when simulating whether something would stun
	{
		if (this.m.ReversePoise + _simulatedAttackPower < _PoiseMax) return 0;
		if (this.m.ReversePoise + _simulatedAttackPower < (_PoiseMax * 2)) return 1;
		return 2;
	}

	function calculatePoiseDamage( _attacker, _skill, _isHeadshot)
	{
		if (!_skill.m.IsDamagingPoise) return 0;

		local poiseDamage = _attacker.getSkills().buildPropertiesForUse(_skill, null).getPoiseDamage();
		if (poiseDamage == 0) return;

		if (_isHeadshot && !this.getContainer().hasSkill("perk.steel_brow"))
		{
			poiseDamage *= this.m.HeadshotMult;
		}
		poiseDamage = ::Math.floor(poiseDamage);

		return poiseDamage;
	}

	// Returns amount of turns that a target would be stunned. Is used for tooltips predicting this
	function wouldStun( _attacker, _skill, _isHeadshot)
	{
		local poiseDamage = this.calculatePoiseDamage(_attacker, _skill, _isHeadshot);
		if (poiseDamage == 0) return 0;

		local myProperties = this.getContainer().buildPropertiesForDefense(_attacker, _skill);
		return this.calculateTurnsStunned(myProperties.getPoiseMax(), poiseDamage);
	}
});
