this.rf_pavise_cover_effect <- ::inherit("scripts/skills/skill", {
	m = {
		MeleeDefenseBonus = 0,
		RangedDefenseBonus = 0
	},
	function create()
	{
		this.m.ID = "effects.rf_pavise_cover";
		this.m.Name = "Pavise Cover";
		this.m.Description = "This character used their spare shield to hide behind while reloading, granting them increased defenses until their next turn.";
		this.m.Icon = "skills/status_effect_03.png";	// same icons as shieldwall
		this.m.IconMini = "status_effect_03_mini";
		this.m.Overlay = "status_effect_03";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = false;		// This debuff does not stack
	}

	function init( _meleeDefense, _rangedDefense )
	{
		this.m.MeleeDefenseBonus = _meleeDefense;
		this.m.RangedDefenseBonus = _rangedDefense;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::MSU.Text.colorizeValue(this.m.MeleeDefenseBonus) + " Melee Defense"
		});

		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = ::MSU.Text.colorizeValue(this.m.RangedDefenseBonus) + " Ranged Defense"
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += this.m.MeleeDefenseBonus;
		_properties.RangedDefense += this.m.RangedDefenseBonus;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onEquip( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Shield))
		{
			this.removeSelf();	// We don't allow double dipping defenses from a shield, even if it's temporary.
		}
	}
});
