::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_cleaver", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_bloodlust", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));
	}

	q.onRemoved = @(__original) function()
	{
		__original();
		this.getContainer().removeByID("perk.rf_bloodlust");
	}

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		if (_targetEntity.isAlive() && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding && !_targetEntity.getCurrentProperties().IsImmuneToBleeding && this.isSkillValid(_skill))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
		}
	}

	q.onQueryTooltip = @(__original) function( _skill, _tooltip )
	{
		__original(_skill, _tooltip);

		if (this.isSkillValid(_skill))
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts additional [Bleeding|Skill+bleeding_effect] due to " + ::Reforged.NestedTooltips.getNestedPerkName(this) + " when dealing at least " + ::MSU.Text.color(::Const.UI.Color.DamageValue, ::Const.Combat.MinDamageToApplyBleeding) + " damage to [Hitpoints|Concept.Hitpoints]")
			});
		}
	}

	q.isSkillValid <- function( _skill )
	{
		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Cleaver);
	}
});
