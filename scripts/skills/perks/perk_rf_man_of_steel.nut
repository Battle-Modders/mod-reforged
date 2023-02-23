this.perk_rf_man_of_steel <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_man_of_steel";
		this.m.Name = ::Const.Strings.PerkName.RF_ManOfSteel;
		this.m.Description = "Attacks against this character don\'t even cause a tickle.";
		this.m.Icon = "ui/perks/rf_man_of_steel.png";
		this.m.IconMini = "rf_man_of_steel_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.getBonus(::Const.BodyPart.Head) == 0 && this.getBonus(::Const.BodyPart.Body) == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local headBonus = this.getBonus(::Const.BodyPart.Head);
		local bodyBonus = this.getBonus(::Const.BodyPart.Body);

		if (headBonus > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Armor penetrating damage through Head Armor is reduced by " + ::MSU.Text.colorGreen(headBonus + "%")
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("This character\'s Head Armor is too damaged")
			});
		}

		if (bodyBonus > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Armor penetrating damage through Body Armor is reduced by " + ::MSU.Text.colorGreen(bodyBonus + "%")
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("This character\'s Body Armor is too damaged")
			});
		}

		return tooltip;
	}

	function getBonus( _bodyPart )
	{
		return ::Math.min(100, this.getContainer().getActor().getArmor(_bodyPart) * 0.1);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		_properties.DamageReceivedDirectMult *= 1.0 - this.getBonus(_hitInfo.BodyPart) * 0.01;
	}
});
