this.perk_rf_hybridization <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		RangedSkillToMeleeMult = 0.1,
		MeleeSkillToRangedMult = 0.2
	},
	function create()
	{
		this.m.ID = "perk.rf_hybridization";
		this.m.Name = ::Const.Strings.PerkName.RF_Hybridization;
		this.m.Description = "This character is skilled in both ranged and melee combat.";
		this.m.Icon = "ui/perks/rf_hybridization.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can switch to or from a throwing weapon for free"
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Will expire upon switching any item"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getMeleeBonus();
		_properties.MeleeSkill += bonus;
		_properties.MeleeDefense += bonus;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && this.isSkillValid(_skill))
		{
			_properties.RangedSkill += this.getRangedBonus();
		}
	}

	function getItemActionCost( _items )
	{
		foreach (item in _items)
		{
			if (item != null && item.isItemType(::Const.Items.ItemType.Weapon) && item.isWeaponType(::Const.Items.WeaponType.Throwing))
				return 0;
		}
	}

	function onPayForItemAction( _skill, _items )
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

	function onQueryTooltip( _skill, _tooltip )
	{
		if (!this.isSkillValid(_skill))
			return;

		local rangedBonus = this.getRangedBonus();
		if (rangedBonus != 0)
		{
			_tooltip.push({
				id = 15,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Has %s chance to hit due to [%s|Skill+%s]", ::MSU.Text.colorizePercentage(rangedBonus), this.getName(), split(::IO.scriptFilenameByHash(this.ClassName), "/").top()))
			});
		}
	}

	function getMeleeBonus()
	{
		return ::Math.floor(this.getContainer().getActor().getBaseProperties().getRangedSkill() * this.m.RangedSkillToMeleeMult);
	}

	function getRangedBonus()
	{
		return ::Math.floor(this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * this.m.MeleeSkillToRangedMult);
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isRanged() || _skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Throwing);
	}
});
