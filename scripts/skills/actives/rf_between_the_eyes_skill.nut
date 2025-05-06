this.rf_between_the_eyes_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsAttacking = false,
		SkillToChanceMult = 0.5
	},
	function create()
	{
		this.m.ID = "actives.rf_between_the_eyes";
		this.m.Name = "Between the Eyes";
		this.m.Description = "Attempt to land your next attack right between your target\'s eyes.";
		this.m.Icon = "skills/rf_between_the_eyes_skill.png";
		this.m.IconDisabled = "skills/rf_between_the_eyes_skill_sw.png";
		this.m.Overlay = "rf_between_the_eyes_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted + 50;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		if (::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			local ret = this.skill.getDefaultUtilityTooltip();
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Perform your weapon\'s primary attack with additional chance to hit the head equal to " + ::MSU.Text.colorPositive((this.m.SkillToChanceMult * 100) + "%") + " of your [Melee Skill|Concept.MeleeSkill]")
			});
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Requires an attack which can exert [Zone of Control|Concept.ZoneOfControl]")
			});
			return ret;
		}

		local ret;
		local aoo = this.getContainer().getAttackOfOpportunity();
		local bonus = this.getBonus();

		if (aoo == null)
		{
			ret = this.skill.getTooltip();
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Requires an attack which can exert [Zone of Control|Concept.ZoneOfControl]"))
			});
		}
		else if (bonus == 0)
		{
			ret = this.skill.getTooltip();
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Too low [Melee Skill|Concept.MeleeSkill] to get any bonus from this skill"))
			});
		}
		else
		{
			ret = this.skill.getDefaultUtilityTooltip();
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Perform a " + ::Reforged.NestedTooltips.getNestedSkillName(aoo) + " with " + ::MSU.Text.colorizeValue(bonus, {AddSign = true, AddPercent = true}) + " chance to hit the head")
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo != null)
		{
			this.m.ActionPointCost += aoo.m.ActionPointCost;
			this.m.FatigueCost += aoo.m.FatigueCost;
			this.m.FatigueCostMult = aoo.m.FatigueCostMult;
			this.m.DirectDamageMult = aoo.m.DirectDamageMult;
			this.m.MinRange = aoo.m.MinRange;
			this.m.MaxRange = aoo.m.MaxRange;
			this.m.IsShieldRelevant = aoo.m.IsShieldRelevant;
		}
	}

	// MSU function
	// overwrite to return AOO damage type instead of our own
	function getDamageType()
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		return aoo == null ? this.skill.getDamageType() : aoo.getDamageType();
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
		return ::Math.max(0, this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * this.m.SkillToChanceMult);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this || this.m.IsAttacking)
		{
			_properties.HitChance[::Const.BodyPart.Head] += this.getBonus();
		}
	}
});
