this.perk_rf_line_breaker <- ::inherit("scripts/skills/skill", {
	m = {
		KnockBackMeleeSkillBonus = 15
	},
	function create()
	{
		this.m.ID = "perk.rf_line_breaker";
		this.m.Name = ::Const.Strings.PerkName.RF_LineBreaker;
		this.m.Description = ::Const.Strings.PerkDescription.RF_LineBreaker;
		this.m.Icon = "ui/perks/perk_rf_line_breaker.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_line_breaker_skill"));
		local offhand = this.getContainer().getActor().getOffhandItem();
		if (offhand != null) this.onEquip(offhand);
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_line_breaker");
	}

	function onEquip( _item )
	{
		if (::MSU.isKindOf(_item, "shield"))
		{
			_item.addSkill(::new("scripts/skills/actives/rf_shield_bash_skill"));
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.knock_back")
		{
			_properties.MeleeSkill += this.m.KnockBackMeleeSkillBonus;
		}
	}

// MSU Functions
	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_skill.getID() == "actives.knock_back")
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.Text.colorizeValue(this.m.KnockBackMeleeSkillBonus, {AddPercent = true}) + " " + this.getName()
			});
		}
	}
});
