this.perk_rf_king_of_all_weapons <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Piercing,
		RequiredWeaponType = ::Const.Items.WeaponType.Spear
	},
	function create()
	{
		this.m.ID = "perk.rf_king_of_all_weapons";
		this.m.Name = ::Const.Strings.PerkName.RF_KingOfAllWeapons;
		this.m.Description = "This character is exceptionally skilled with the spear, which is known by many to be the king of all weapons.";
		this.m.Icon = "ui/perks/perk_rf_king_of_all_weapons.png";
		this.m.IconMini = "perk_rf_king_of_all_weapons_mini";
		this.m.Type = ::Const.SkillType.Perk;
		// We want the Order to be rather late so that our adjustments to headshot chance are
		// properly calculated when previewing and properly applied when not previewing.
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !this.isSkillValid(_skill))
			return;

		local headArmor = _targetEntity.getArmor(::Const.BodyPart.Head);
		local bodyArmor = _targetEntity.getArmor(::Const.BodyPart.Body);
		local isHeadLower = headArmor < bodyArmor;
		local isBodyLower = bodyArmor < headArmor;

		local chance = this.getChance();
		local actor = this.getContainer().getActor();
		if (actor.isPreviewing())
		{
			// Probability of this perk succeeding = chance
			// Probability of this perk failing = 1.0 - chance * 0.01
			// Note: We set the HitChanceMult to 1.0 because we use `_properties.getHitchance` to calculate
			// the real headshot chance which already takes into account the mult. So once we adjust the chance
			// we need to set the mult to 1.0 so that our calculated chance isn't further multiplied.
			if (isHeadLower)
			{
				_properties.HitChance[::Const.BodyPart.Head] = chance + (1.0 - chance * 0.01) * _properties.getHitchance(::Const.BodyPart.Head);
				_properties.HitChanceMult[::Const.BodyPart.Head] = 1.0;
			}
			else if (isBodyLower)
			{
				_properties.HitChance[::Const.BodyPart.Head] = (1.0 - chance * 0.01) * _properties.getHitchance(::Const.BodyPart.Head);
				_properties.HitChanceMult[::Const.BodyPart.Head] = 1.0;
			}
		}
		else if (::Math.rand(1, 100) < chance)
		{
			if (isHeadLower)
			{
				// Just setting the mult for body to 0 is not enough, we also have to set the chance for head to 100
				// because in skill.onScheduledTargetHit and characterProperties.getHitchance functions the way it is
				// decided whether it hits the head or body is by checking the chance to hit the head against Math.rand(1, 100)
				_properties.HitChance[::Const.BodyPart.Head] = 100.0;
				_properties.HitChanceMult[::Const.BodyPart.Body] = 0.0;
			}
			else if (isBodyLower)
			{
				_properties.HitChance[::Const.BodyPart.Body] = 100.0;
				_properties.HitChanceMult[::Const.BodyPart.Head] = 0.0;
			}
		}
	}

	function getChance()
	{
		return ::Math.floor(this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * 0.66);
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.isSkillValid(_skill))
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = ::Const.Perks.findById(this.getID()).Icon,
				text = ::Reforged.Mod.Tooltips.parseString(format("Has %s chance to target the body part with the lower armor", ::MSU.Text.colorPositive(this.getChance() + "%")))
			});
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
