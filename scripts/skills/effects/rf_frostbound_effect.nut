this.rf_frostbound_effect <- ::inherit("scripts/skills/skill", {
	m = {
		HitpointsTransferPct = 0.05,
		FatigueAtTurnStart = 2,
		HealingMult = 2.0, // multiplier to the hitpoints transferred to you
		EffectMult = 1.0
	},
	function create()
	{
		this.m.ID = "effects.rf_frostbound";
		this.m.Name = "Frostbound";
		this.m.Description = "A deathly cold emanates from this character, sapping the living warmth from those who draw breath nearby.";
		this.m.KilledString = "Frozen to death";
		this.m.Icon = "skills/rf_frostbound_effect.png";
		this.m.Overlay = "rf_frostbound_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;

		this.m.SoundOnUse = [
			"sounds/enemies/rf_frostbound_effect_01.wav",
			"sounds/enemies/rf_frostbound_effect_02.wav"
		];
	}

	function softReset()
	{
		this.skill.softReset();
		this.resetField("EffectMult");
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = ::Reforged.Mod.Tooltips.parseString("Characters ending their [turn|Concept.Turn] adjacent to you lose " + ::MSU.Text.colorizePct(this.m.HitpointsTransferPct, {InvertColor = true}) + " of their [Hitpoints|Concept.Hitpoints] and you heal for double the amount")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString("Characters starting their [turn|Concept.Turn] adjacent to you build " + ::MSU.Text.colorizeValue(this.m.FatigueAtTurnStart, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
		});

		return ret;
	}

	function onActorSpawned( _actor )
	{
		if (!::MSU.isKindOf(_actor, "rf_draugr") && !_actor.getSkills().hasSkill("special.rf_frostbound_manager"))
		{
			_actor.getSkills().add(::new("scripts/skills/special/rf_frostbound_manager"));
		}
	}

	function onEnemyTurnStart( _enemy )
	{
		_enemy.setFatigue(::Math.min(_enemy.getFatigueMax(), _enemy.getFatigue() + this.m.FatigueAtTurnStart * this.m.EffectMult));
	}

	function onEnemyTurnEnd( _enemy )
	{
		this.spawnIcon(this.m.Overlay, _enemy.getTile());

		local hitInfo = ::MSU.Table.merge(clone ::Const.Tactical.HitInfo, {
			DamageRegular = ::Math.round(_enemy.getHitpoints() * this.m.HitpointsTransferPct * this.m.EffectMult),
			DamageDirect = 1.0,
			BodyPart = ::Const.BodyPart.Body,
			BodyDamageMult = 1.0,
			FatalityChanceMult = 0.0
		});

		local actor = this.getContainer().getActor();
		_enemy.onDamageReceived(actor, this, hitInfo);
		actor.setHitpoints(::Math.min(actor.getHitpointsMax(), actor.getHitpoints() + this.m.HealingMult * hitInfo.DamageRegular));
	}
});
