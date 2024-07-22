this.rf_cleaving_swing_skill <- ::inherit("scripts/skills/actives/swing", {
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
		this.swing.create();
		this.m.ID = "actives.rf_cleaving_swing";
		this.m.Name = "Cleaving Swing";
		this.m.Description = "Swinging the weapon in a wide arc that hits three adjacent tiles in counter-clockwise order. Be careful around your own men unless you want to relieve your payroll!";
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Swing;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 3 targets"
		});

		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking " + ::MSU.Text.colorDamage(dmg) + " bleeding damage per turn, for 2 turns"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
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
