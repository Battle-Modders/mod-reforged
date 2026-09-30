this.rf_obsidian_gash_skill <- ::inherit("scripts/skills/actives/gash_skill", {
	m = {
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		]
	},
    function create()
	{
        this.gash_skill.create();
        // does not change id or name of the skill here
        this.m.Description = "A skillful combination of slash and pierce that cripples your target with bleed, injury and wither.";
        this.m.KilledString = "Sacrificed";
        // TODO: make cooler art for legendary weapon
		this.m.Icon = "skills/active_189.png";
		this.m.IconDisabled = "skills/active_189_sw.png";
		this.m.Overlay = "active_189";
		this.m.InjuriesOnBody = this.Const.Injury.CuttingAndPiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingAndPiercingBody;
        this.m.FatigueCost = 15;
        this.m.BleedStacks = 3;
        this.m.MeleeSkillAdd = 0;
    }
    
	function getTooltip()
	{
		local ret = this.getDefaultTooltip();

		if (this.m.MeleeSkillAdd != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizeValue(this.m.MeleeSkillAdd, {AddSign = true, AddPercent = true}) + " chance to hit"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("Has a " + ::MSU.Text.colorNegative("50%") + " lower [threshold|Concept.InjuryThreshold] to inflict [injuries|Concept.InjuryTemporary]")
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("Has a " + ::MSU.Text.colorNegative("33%") + " lower [threshold|Concept.InjuryThreshold] to inflict [injuries|Concept.InjuryTemporary]")
			});
		}

		if (this.m.BleedStacks != 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Applies " + ::MSU.Text.colorPositive(this.m.BleedStacks) + " stacks of [$ $|Skill+bleeding_effect] when inflicting at least " + ::MSU.Text.color(::Const.UI.Color.DamageValue, ::Const.Combat.MinDamageToApplyBleeding) + " damage to [Hitpoints|Concept.Hitpoints]")
			});
		}

        ret.push({
            id = 8,
            type = "text",
            icon = "ui/icons/special.png",
            text = ::Reforged.Mod.Tooltips.parseString("Applies [$ $|Skill+withered_effect] when inflicting at least " + ::MSU.Text.color(::Const.UI.Color.DamageValue, ::Const.Combat.PoisonEffectMinDamage) + " damage to [Hitpoints|Concept.Hitpoints]")
        });

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.MeleeSkillAdd;
			// this.m.HitChanceBonus is set by Modular Vanilla based on changes to _properties.MeleeSkill
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			for (local i = 0; i < this.m.BleedStacks; i++)
			{
				_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
			}
		}
	}

    function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
			if (this.m.ActionPointCost > 1)
			{
				this.m.ActionPointCost -= 1;
			}
		}
	}

    function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this)
		{
            if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
            {
                _hitInfo.InjuryThresholdMult *= 0.5;
            }
            else
            {
                _hitInfo.InjuryThresholdMult *= 0.66;
            }

            if (_targetEntity.isAlive() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
            {
                this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
            }
		}
	}
});