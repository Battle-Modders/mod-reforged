this.rf_internal_hemorrhage_effect <- ::inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		Damage = 0,
		LastRoundApplied = 0,
		Attacker = null
	},
	function getDamage()
	{
		return this.m.Damage;
	}

	function setDamage( _d )
	{
		this.m.Damage = _d;
	}

	function setAttacker( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function create()
	{
		this.m.ID = "effects.rf_internal_hemorrhage";
		this.m.Name = "Hemorrhaging Internally";
		this.m.KilledString = "Bled to death";
		this.m.Icon = "skills/status_effect_01.png";
		this.m.IconMini = "status_effect_01_mini";
		this.m.Overlay = "bleed";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DamageOverTime;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is suffering from profuse internal bleeding from a recently received hit and will lose [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function getAttacker()
	{
		if (!::MSU.isNull(this.m.Attacker) && this.m.Attacker.isAlive() && this.m.Attacker.isPlacedOnMap())
		{
			return this.m.Attacker;
		}

		return this.getContainer().getActor();
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != ::Time.getRound())
		{
			this.m.LastRoundApplied = ::Time.getRound();
			this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getAttacker(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}

	function onAdded()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && ::Math.rand(1, 100) <= 50)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " had his internal hermorrhage stop thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = ::Math.max(1, this.m.TurnsLeft + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

			if (this.getContainer().hasSkill("trait.bleeder"))
			{
				++this.m.TurnsLeft;
			}
		}
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}
});
