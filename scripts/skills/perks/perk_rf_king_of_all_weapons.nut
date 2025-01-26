this.perk_rf_king_of_all_weapons <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Piercing,
		RequiredWeaponType = ::Const.Items.WeaponType.Spear,
		Chance = 40
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

		local damageTypeString = this.m.RequiredDamageType == null ? "" : " " + ::Const.Damage.getDamageTypeName(this.m.RequiredDamageType);
		local weaponTypeString = this.m.RequiredWeaponType == null ? "" : " from a " + ::Const.Items.getWeaponTypeName(this.m.RequiredWeaponType).tolower();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("All%s attack%s during your [turn|Concept.Turn] have a %s chance to target the body part with the lower armor", damageTypeString, weaponTypeString, ::MSU.Text.colorPositive(this.m.Chance + "%")))
		});

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.isSkillValid(_skill))
			return;

		if (_targetEntity != null && ::Math.rand(1, 100) <= this.m.Chance)
		{
			local headArmor = _targetEntity.getArmor(::Const.BodyPart.Head);
			local bodyArmor = _targetEntity.getArmor(::Const.BodyPart.Body);
			if (headArmor < bodyArmor)
			{
				// Just setting the mult for body to 0 is not enough, we also have to set the chance for head to 100
				// because in skill.onScheduledTargetHit and characterProperties.getHitchance functions the way it is
				// decided whether it hits the head or body is by checking the chance to hit the head against Math.rand(1, 100)
				_properties.HitChance[::Const.BodyPart.Head] = 100.0;
				_properties.HitChanceMult[::Const.BodyPart.Body] = 0.0;
			}
			else if (bodyArmor < headArmor)
			{
				_properties.HitChance[::Const.BodyPart.Body] = 100.0;
				_properties.HitChanceMult[::Const.BodyPart.Head] = 0.0;
			}
		}
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
