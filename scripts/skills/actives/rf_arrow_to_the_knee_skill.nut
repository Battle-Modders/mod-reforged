this.rf_arrow_to_the_knee_skill <- ::inherit("scripts/skills/actives/quick_shot", {
	m = {},
	function create()
	{
		this.quick_shot.create();
		this.m.ID = "actives.rf_arrow_to_the_knee";
		this.m.Name = "Arrow to the Knee";
		this.m.Description = "A debilitating shot aimed at the knees of your target causing them to spend additional Action Points per tile moved.";
		this.m.Icon = "skills/rf_arrow_to_the_knee_skill.png";
		this.m.IconDisabled = "skills/rf_arrow_to_the_knee_skill_sw.png";
		this.m.Overlay = "rf_arrow_to_the_knee_skill";
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.AdditionalAccuracy = -10;
		this.m.AdditionalHitChance = -4;
	}

	function getTooltip()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will apply the [Arrow to the Knee|Skill+rf_arrow_to_the_knee_debuff_effect] on the target on a hit")
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will [Stagger|Skill+staggered_effect] the target on a hit")
		});

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has " + ::MSU.Text.colorPositive(ammo) + " arrows left"
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Needs a non-empty quiver of arrows equipped")
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used because this character is engaged in melee")
			});
		}

		return tooltip;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive())
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_arrow_to_the_knee_debuff_effect"));
			_targetEntity.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.quick_shot.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			_properties.HitChanceMult[::Const.BodyPart.Head] *= 0.0;
		}
	}
});
