this.perk_rf_steady_brace <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = true,
		DirectDamageAddModifier = 0.2,
		RangedSkillModifier = 20
	},
	function create()
	{
		this.m.ID = "perk.rf_steady_brace";
		this.m.Name = ::Const.Strings.PerkName.RF_SteadyBrace;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SteadyBrace;
		this.m.Icon = "ui/perks/perk_rf_steady_brace.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.IsSpent || !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("Crossbows have " + ::MSU.Text.colorizeMult(1.0 + this.m.DirectDamageAddModifier, {AddSign = true}) + " armor penetration")
			});
		}
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("Firearms have " + ::MSU.Text.colorizeValue(this.m.RangedSkillModifier, {AddSign = true, AddPercent = true}) + " chance to hit")
			});
		}

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon moving or swapping any item")
		});
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsSpent || !this.isSkillValid(_skill))
			return;

		local weapon = _skill.getItem();

		if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
		{
			_properties.DirectDamageAdd += this.m.DirectDamageAddModifier;
		}
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			_properties.RangedSkill += this.m.RangedSkillModifier;
		}
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsSpent = true;
	}

	function onMovementFinished( _tile )
	{
		this.m.IsSpent = true;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || !_skill.isRanged())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Crossbow | ::Const.Items.WeaponType.Firearm);
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null)
			return false;

		foreach (s in weapon.getSkills())
		{
			if (this.isSkillValid(s))
				return true;
		}

		return false;
	}
});
