this.rf_cleaving_split_skill <- ::inherit("scripts/skills/actives/split", {
	m = {
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		],
		SoundsB = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		]
	},
	function create()
	{
		this.split.create();
		this.m.ID = "actives.rf_cleaving_split";
		this.m.Name = "Cleaving Split";
		this.m.Description = "A wide-swinging overhead attack performed for maximum reach rather than force that can hit two tiles in a straight line.";
		this.m.KilledString = "Cleaved in two";
		this.m.Icon = "skills/rf_cleaving_split_skill.png";
		this.m.IconDisabled = "skills/rf_cleaving_split_skill_sw.png";
		this.m.Overlay = "rf_cleaving_split_skill";
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Split;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 2 targets"
		});

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Inflicts [Bleeding|Skill+bleeding_effect] when dealing at least " + ::MSU.Text.color(::Const.UI.Color.DamageValue, ::Const.Combat.MinDamageToApplyBleeding) + " damage to [Hitpoints|Concept.Hitpoints]")
		});

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInCleavers)
		{
			this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.skill.onAnySkillUsed(_skill, _targetEntity, _properties);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this)
			return;

		if (!_targetEntity.isAlive())
		{
			if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			{
				::Sound.play(this.m.SoundsB[::Math.rand(0, this.m.SoundsB.len() - 1)], ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
			else
			{
				::Sound.play(this.m.SoundsA[::Math.rand(0, this.m.SoundsA.len() - 1)], ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		}
		else if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			local effect = ::new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
			_targetEntity.getSkills().add(effect);
			::Sound.play(this.m.SoundsA[::Math.rand(0, this.m.SoundsA.len() - 1)], ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
		}
		else
		{
			::Sound.play(this.m.SoundsB[::Math.rand(0, this.m.SoundsB.len() - 1)], ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
		}
	}
});
