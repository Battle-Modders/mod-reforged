this.rf_draugr_racial <- ::inherit("scripts/skills/skill", {
	m = {
		DamageReductionPerMoraleState = 0.1,
		DamageMult_Burning = 1.5
	},
	function create()
	{
		this.m.ID = "racial.rf_draugr";
		this.m.Name = "Barrowkin";
		this.m.Description = "This character is a Barrowkin.";
		this.m.Icon = "ui/orientation/rf_draugr_thrall_orientation.png";
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/campfire.png",
			text = ::MSU.Text.colorizeMultWithText(this.m.DamageMult_Burning, {InvertColor = true}) + " burning damage received"
		});
		if (this.m.DamageReductionPerMoraleState != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString("Receive " + ::MSU.Text.colorizePct(this.m.DamageReductionPerMoraleState) + " less melee damage per [morale|Concept.Morale] state the attacker is below Steady")
			});
		}
		ret.extend([
			{id = 15,	type = "text",	icon = "ui/icons/fatigue.png",	text = ::Reforged.Mod.Tooltips.parseString("Not affected by [Fatigue|Concept.Fatigue]")},
			{id = 16,	type = "text",	icon = "ui/icons/special.png",	text = ::Reforged.Mod.Tooltips.parseString("Not affected by [$ $|Skill+night_effect]")},
			{id = 17,	type = "text",	icon = "ui/icons/special.png",	text = ::Reforged.Mod.Tooltips.parseString("Immune to [$ $|Skill+bleeding_effect]")},
			{id = 18,	type = "text",	icon = "ui/icons/special.png",	text = ::Reforged.Mod.Tooltips.parseString("Immune to poison")},
		]);
		return ret;
	}

	function onAdded()
	{
		local b = this.getContainer().getActor().getBaseProperties();
		b.FatigueEffectMult = 0.0;
		b.IsAffectedByNight = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.DamageType == ::Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedRegularMult *= this.m.DamageMult_Burning;
		}

		if (_attacker == null || _skill == null || !_skill.isAttack() || _skill.isRanged())
			return;

		_properties.DamageReceivedRegularMult *= this.getDamageReceivedRegularMult(_attacker, _skill);
	}

	function getDamageReceivedRegularMult( _attacker, _skill )
	{
		if (!_skill.isAttack() || _skill.isRanged())
			return 1.0;

		return 1.0 - this.m.DamageReductionPerMoraleState * ::Math.max(0, ::Const.MoraleState.Steady - _attacker.getMoraleState());
	}
});
