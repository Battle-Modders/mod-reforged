this.rf_cheap_trick_skill <- ::inherit("scripts/skills/skill", {
	m = {
		// Config
		HitChanceModifier = 25,
		DamageRegularMult = 0.50,

		// Private
		IsSpent = false,
	},
	function create()
	{
		this.m.ID = "actives.rf_cheap_trick";
		this.m.Name = "Cheap Trick";
		this.m.Description = "Deceive your enemies and strike with precision, sacrificing power for accuracy with your next attack this turn.";
		this.m.Icon = "skills/rf_cheap_trick_skill.png";
		this.m.IconDisabled = "skills/rf_cheap_trick_skill_sw.png";
		this.m.Overlay = "rf_cheap_trick_skill";
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 10;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		if (this.m.HitChanceModifier != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Gain " + ::MSU.Text.colorizePercentage(this.m.HitChanceModifier) + " chance to hit with your next attack",
			});
		}

		if (this.m.DamageRegularMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/damage_regular.png",
				text = ::Reforged.Mod.Tooltips.parseString("Deal " + ::MSU.Text.colorizeMult(this.m.DamageRegularMult ) + " less damage with your next attack"),
			});
		}

		if (this.m.IsSpent)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed(::Reforged.Mod.Tooltips.parseString("Can only be used once per [turn|Concept.Turn]")),
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.m.IsSpent;
	}

	function onUse( _user, _targetTile )
	{
		local self = this;
		this.getContainer().add(::MSU.new("scripts/skills/effects/rf_cheap_trick_effect", function(o) {
			o.m.HitChanceModifier = self.m.HitChanceModifier;
			o.m.DamageRegularMult = self.m.DamageRegularMult;
		}));
		this.m.IsSpent = true;

		return true;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}
});
