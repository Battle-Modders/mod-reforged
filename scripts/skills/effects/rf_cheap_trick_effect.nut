this.rf_cheap_trick_effect <- ::inherit("scripts/skills/skill", {
	m = {
		// Config
		HitChanceModifier = 0,		// Must be set during initialization
		DamageRegularMult = 1.0,	// Must be set during initialization
	},
	function create()
	{
		this.m.ID = "effects.rf_cheap_trick";
		this.m.Name = "Cheap Trick";
		this.m.Description = "Perform a quick and deceptive move to catch opponents off-guard, allowing for a higher chance of landing a hit but at the cost of power.";
		this.m.Icon = "ui/perks/perk_rf_cheap_trick.png";
		this.m.Overlay = "rf_cheap_trick_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.HitChanceModifier != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::MSU.Text.colorizeValue(this.m.HitChanceModifier, {AddSign = true, AddPercent = true}) + " chance to hit with your next attack"
			});
		}

		if (this.m.DamageRegularMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/damage_regular.png",
				text = ::Reforged.Mod.Tooltips.parseString("The attack deals " + ::MSU.Text.colorizeMult(this.m.DamageRegularMult ) + " less damage")
			});
		}

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon using [Wait|Concept.Wait] or ending the [turn|Concept.Turn]")
		});

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.isSkillValid(_skill))
		{
			_properties.MeleeSkill += this.m.HitChanceModifier;
			_properties.RangedSkill += this.m.HitChanceModifier;
			_properties.DamageRegularMult *= this.m.DamageRegularMult;
		}
	}

	function onWaitTurn()
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

// MSU Functions
	function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.isSkillValid(_skill))
		{
			this.removeSelf();
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (this.isSkillValid(_skill) && _targetTile.IsOccupiedByActor)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.Text.colorizeValue(this.m.HitChanceModifier, {AddSign = true, AddPercent = true}) + " " + this.getName()
			});
		}
	}

// New Functions
	function isSkillValid( _skill )
	{
		return _skill.isAttack();
	}
});
