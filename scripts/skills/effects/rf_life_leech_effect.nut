this.rf_life_leech_effect <- ::inherit("scripts/skills/skill", {
	m = {
		LifeLeechValue = 1.0,   // 1.0 equals to 100% damage leeched as life
        LeechDistance = 1,	// 1 only allows leeching from adjacent enemies
		ForceHeal = false   // Temporary helper variable
	},
	function create()
	{
		this.m.ID = "effects.rf_life_leech";
		this.m.Name = "Life Leech";
		this.m.Description = "This character recovers Hitpoints when dealing damage to enemies with blood.";
		this.m.Icon = "skills/status_effect_09.png";
		this.m.Overlay = "status_effect_09";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_life_drain_01.wav",
			"sounds/enemies/vampire_life_drain_02.wav",
			"sounds/enemies/vampire_life_drain_03.wav"
		];
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local withinText = this.m.LeechDistance == 1 ? "adjacent enemies" : "enemies within " + ::MSU.Text.colorGreen(this.m.LeechDistance) + " tiles";
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Heal " + ::MSU.Text.colorGreen((this.m.LifeLeechValue * 100) + "%") + " of Hitpoint damage inflicted on " + withinText + " that have blood"
        });

		return ret;
	}

	function onCombatStarted()
	{
		this.m.ForceHeal = false;
	}

	function onCombatFinished()
	{
		this.m.ForceHeal = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints <= 0) return;
		if (this.m.ForceHeal)      // If our attack killed the target we instead handle the leeching in here
		{
			this.leechLife(_damageInflictedHitpoints);
			this.m.ForceHeal = false;
			return;
		}
		local actor = this.getContainer().getActor();
		if (actor.getHitpoints() == actor.getHitpointsMax()) return;
		if (!_targetEntity.isAlive()) return;      // Otherwise we crash the game when leeching from a killing blow
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding) return;
		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > this.m.LeechDistance) return;

		this.leechLife(_damageInflictedHitpoints);
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding) return;
		local actor = this.getContainer().getActor();
		if (actor.getHitpoints() == actor.getHitpointsMax()) return;
		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > this.m.LeechDistance) return;
		this.m.ForceHeal = true;
	}

	function leechLife( _damageInflicted )
	{
		local actor = this.getContainer().getActor();
		this.spawnIcon("status_effect_09", actor.getTile());
		local hitpointsHealed = ::Math.round(_damageInflicted * this.m.LifeLeechValue);

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect, actor.getPos());
			}

			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " heals for " + ::Math.min(actor.getHitpointsMax() - actor.getHitpoints(), hitpointsHealed) + " points");
		}

		actor.setHitpoints(::Math.min(actor.getHitpointsMax(), actor.getHitpoints() + hitpointsHealed));
		actor.onUpdateInjuryLayer();
	}
});

