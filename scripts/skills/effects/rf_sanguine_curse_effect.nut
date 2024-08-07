this.rf_sanguine_curse_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Damage = 10,
		StaminaMult = 0.8,
		FatigueRecoveryAdd = -3,
		TurnsLeft = 2,
		Caster = null
	},
	function create()
	{
		this.m.ID = "effects.rf_sanguine_curse";
		this.m.Name = "Sanguine Curse";
		this.m.Description = "This character has received a curse that drains their blood and stamina over time.";
		this.m.KilledString = "Drained";
		this.m.Icon = "skills/rf_sanguine_curse_effect.png";
		this.m.IconMini = "rf_sanguine_curse_effect_mini";
		this.m.Overlay = "rf_sanguine_curse_effect";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/hexe_hex_damage_01.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_02.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_03.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_04.wav"
		];
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function isHidden()
	{
		return ::MSU.isNull(this.m.Caster);
	}

	function setCaster( _entity )
	{
		this.m.Caster = _entity == null ? null : ::MSU.asWeakTableRef(_entity);
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = ::Reforged.Mod.Tooltips.parseString("At the end of the [turn|Concept.Turn], " + ::MSU.Text.colorNegative(this.m.Damage) + " [Hitpoints|Concept.Hitpoints] are transferred to " + (::MSU.isNull(this.m.Caster) ? " the caster" : this.m.Caster.getName()))
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.StaminaMult) + " less [Maximum Fatigue|Concept.Fatigue]")
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative(this.m.FatigueRecoveryAdd) + " [Fatigue Recovery|Concept.FatigueRecovery]")
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.StaminaMult *= this.m.StaminaMult;
		_properties.FatigueRecoveryRate += this.m.FatigueRecoveryAdd;
	}

	function onTurnEnd()
	{
		if (!::MSU.isNull(this.m.Caster) && this.m.Caster.isPlacedOnMap() && this.m.Caster.isAlive())
		{
			local actor = this.getContainer().getActor();
			this.spawnIcon("rf_sanguine_curse_effect", actor.getTile());
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.m.Caster, this, hitInfo);
			if (this.m.SoundOnUse.len() != 0)
			{
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect, actor.getPos());
			}
			this.m.Caster.setHitpoints(::Math.min(this.m.Caster.getHitpointsMax(), this.m.Caster.getHitpoints() + this.m.Damage));
		}

		if (--this.m.TurnsLeft == 0)
		{
			this.removeSelf();
		}
	}

	function onRemoved()
	{
		if (!::MSU.isNull(this.m.Caster))
		{
			local skill = this.m.Caster.getSkills().getSkillByID("actives.rf_sanguine_curse");

			if (skill != null)
			{
				skill.setVictim(null);
			}
			this.m.Caster = null;
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}
});
