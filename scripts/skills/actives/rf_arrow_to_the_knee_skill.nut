this.rf_arrow_to_the_knee_skill <- ::inherit("scripts/skills/actives/quick_shot", {
	m = {},
	function create()
	{
		this.quick_shot.create();
		this.m.ID = "actives.rf_arrow_to_the_knee";
		this.m.Name = "Arrow to the Knee";
		this.m.Description = "A debilitating shot aimed at the knees of your target to cripple their ability to move and defend themselves. Can only be used against targets who can receive leg injuries.";
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
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will apply [Arrow to the Knee|Skill+rf_arrow_to_the_knee_debuff_effect] effect to the target on a hit")
		});

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has " + ::MSU.Text.colorPositive(ammo) + " arrows left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Needs a non-empty quiver of arrows equipped")
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used because this character is [engaged|Concept.ZoneOfControl] in melee"))
			});
		}

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && this.RF_isTargetValid(_targetTile.getEntity());
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && this.RF_isTargetValid(_targetEntity))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_arrow_to_the_knee_debuff_effect"));
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

	// Valid target is someone who is not immune to injuries and can receive a leg type injury
	function RF_isTargetValid( _targetEntity )
	{
		if (!_targetEntity.getCurrentProperties().IsAffectedByInjuries)
			return false;

		// Const.Injuries.ExcludedInjuries is an MSU feature
		local legInjuries = ::Const.Injuries.ExcludedInjuries.get(::Const.Injuries.ExcludedInjuries.Leg);
		return legInjuries.filter(@(_, _id) _targetEntity.m.ExcludedInjuries.find(_id) == null).len() != 0;
	}
});
