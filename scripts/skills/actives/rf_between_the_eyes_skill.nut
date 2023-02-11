this.rf_between_the_eyes_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsAttacking = false
	},
	function create()
	{
		this.m.ID = "actives.rf_between_the_eyes";
		this.m.Name = "Between the Eyes";
		this.m.Description = "Attempt to land your next attack right between your target\'s eyes.";
		this.m.Icon = "skills/rf_between_the_eyes_skill.png";
		this.m.IconDisabled = "skills/rf_between_the_eyes_skill_bw.png";
		this.m.Overlay = "rf_between_the_eyes_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local tooltip;
		local aoo = this.getContainer().getAttackOfOpportunity();
		local bonus = this.getBonus();

		if (aoo == null)
		{
			tooltip = this.skill.getTooltip();
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Requires an attack which can exert Zone of Control")
			});
		}
		else if (bonus == 0)
		{
			tooltip = this.skill.getTooltip();
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Too low Melee Skill to get any bonus from this skill")
			});
		}
		else
		{
			tooltip = this.skill.getDefaultTooltip();
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Perform a " + ::MSU.Text.colorRed(this.getContainer().getAttackOfOpportunity().getName()) + " with " + ::MSU.Text.colorizePercentage(bonus) + " chance to hit the head"
			});
		}

		return tooltip;
	}

	function onAfterUpdate( _properties )
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo != null)
		{
			this.m.DamageType = aoo.getDamageType().weakref();
			this.m.ActionPointCost += aoo.m.ActionPointCost;
			this.m.FatigueCost += aoo.m.FatigueCost;
			this.m.FatigueCostMult = aoo.m.FatigueCostMult;
			this.m.DirectDamageMult = aoo.m.DirectDamageMult;
			this.m.MinRange = aoo.m.MinRange;
			this.m.MaxRange = aoo.m.MaxRange;
		}
		else
		{
			this.m.DamageType = null;
		}
	}

	function isUsable()
	{
		local headHunter = this.getContainer().getSkillByID("perk.head_hunter");
		if (headHunter != null && !headHunter.isHidden())
		{
			return false;
		}

		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo == null)
		{
			return false;
		}

		return aoo.isUsable();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo == null)
		{
			return false;
		}

		return aoo.onVerifyTarget(_originTile, _targetTile);
	}

	// This skill really just serves as a proxy for the AOO. It's job is to trigger the AOO on the target tile
	function onUse( _user, _targetTile )
	{
		local aoo = this.getContainer().getAttackOfOpportunity()

		local overlay = aoo.m.Overlay;
		aoo.m.Overlay = "";

		this.m.IsAttacking = true;
		local ret = aoo.useForFree(_targetTile);
		this.m.IsAttacking = false;

		aoo.m.Overlay = overlay;

		return ret;
	}

	function getBonus()
	{
		return ::Math.max(0, this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * 0.5);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (skill == this || this.m.IsAttacking)
		{
			_properties.HitChance[::Const.BodyPart.Head] += this.getBonus();
		}
	}
});
