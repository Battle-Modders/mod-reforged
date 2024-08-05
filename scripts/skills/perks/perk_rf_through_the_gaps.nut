this.perk_rf_through_the_gaps <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Piercing,
		RequiredWeaponType = ::Const.Items.WeaponType.Spear,
		IsSpent = true,
		DirectDamageModifier = 0.10
	},
	function create()
	{
		this.m.ID = "perk.rf_through_the_gaps";
		this.m.Name = ::Const.Strings.PerkName.RF_ThroughTheGaps;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ThroughTheGaps;
		this.m.Icon = "ui/perks/perk_rf_through_the_gaps.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		if (this.m.DirectDamageModifier != 0)
		{
			local damageTypeString = this.m.RequiredDamageType == null ? "" : " " + ::Const.Damage.getDamageTypeName(this.m.RequiredDamageType).tolower();
			local weaponTypeString = this.m.RequiredWeaponType == null ? "" : " from a " + ::Const.Items.getWeaponTypeName(this.m.RequiredWeaponType).tolower();
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = format("The next%s attack%s deals %s damage ignoring armor", damageTypeString, weaponTypeString, ::MSU.Text.colorizeValue(::Math.floor(this.m.DirectDamageModifier * 100)), {AddSign = true, AddPercent = true})
			});
		}

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This attack will target the body part with the lower armor"
		});
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsSpent || !this.isSkillValid(_skill))
			return;

		_properties.DamageDirectAdd += this.m.DirectDamageModifier;

		if (_targetEntity != null)
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
		if (_skill.isRanged() || !_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
