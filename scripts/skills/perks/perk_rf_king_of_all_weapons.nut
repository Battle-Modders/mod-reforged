this.perk_rf_king_of_all_weapons <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = true,
		ActionPointsModifier = -1,
		DamageTotalMult = 1.25
	},
	function create()
	{
		this.m.ID = "perk.rf_king_of_all_weapons";
		this.m.Name = ::Const.Strings.PerkName.RF_KingOfAllWeapons;
		this.m.Description = "This character is exceptionally skilled with the spear, which is known by many to be the king of all weapons.";
		this.m.Icon = "ui/perks/perk_rf_king_of_all_weapons.png";
		this.m.IconMini = "perk_rf_king_of_all_weapons_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		if (this.m.DamageTotalMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("The next attack from a spear during your [turn|Concept.Turn] deals %s %s damage", ::MSU.Text.colorizeMult(this.m.DamageTotalMult), this.m.DamageTotalMult < 1.0 ? "less" : "more"))
			});
		}
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		foreach (skill in this.getContainer().m.Skills)
		{
			if (!skill.isGarbage() && this.isSkillValid(skill))
			{
				if (this.m.ActionPointsModifier > 0 || skill.m.ActionPointCost > 1)
					skill.m.ActionPointCost += this.m.ActionPointsModifier;
			}

		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.m.IsSpent && this.isSkillValid(_skill) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			_properties.DamageTotalMult *= this.m.DamageTotalMult;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.isSkillValid(_skill) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
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
		if (_skill.isRanged() || !_skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Spear);
	}
});
