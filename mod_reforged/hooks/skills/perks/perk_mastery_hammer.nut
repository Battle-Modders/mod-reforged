::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_hammer", function(q) {
	q.m.DentArmorSkills <- [
		"actives.demolish_armor",
		"actives.crush_armor"
	];
	q.m.MinArmorToDent <- 250;

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		if (_targetEntity.isAlive() && _targetEntity.getArmorMax(_bodyPart) >= this.m.MinArmorToDent && this.m.DentArmorSkills.find(_skill.getID()) != null && !_targetEntity.getSkills().hasSkill("effects.rf_dented_armor"))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_dented_armor_effect"));
		}
	}

	q.onQueryTooltip = @(__original) function( _skill, _tooltip )
	{
		local ret = __original(_skill, _tooltip);
		if (this.m.DentArmorSkills.find(_skill.getID()) != null)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Applies the [Dented Armor|Skill+rf_dented_armor_effect] effect on a hit")
			});
		}
	}

	q.onEquip = @(__original) function( _item )
	{
		__original(_item);
		if (_item.isItemType(::Const.Items.ItemType.TwoHanded) && _item.isItemType(::Const.Items.ItemType.Weapon) && _item.isWeaponType(::Const.Items.WeaponType.Hammer))
		{
			_item.addSkill(::new("scripts/skills/actives/rf_pummel_skill"));
		}
	}
});
