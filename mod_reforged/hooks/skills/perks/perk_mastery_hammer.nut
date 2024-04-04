::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_hammer", function(q) {
	q.m.DentArmorSkills <- [
		"actives.demolish_armor",
		"actives.crush_armor"
	];
	q.m.MinArmorToDent <- 250;

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		if (!_targetEntity.isAlive() || _targetEntity.getArmorMax(_bodyPart) < this.m.MinArmorToDent || this.m.DentArmorSkills.find(_skill.getID()) == null || _targetEntity.getSkills().hasSkill("effects.rf_dented_armor"))
			return;

		local armorItem = _bodyPart == ::Const.BodyPart.Head ? _targetEntity.getHeadItem() : _targetEntity.getBodyItem();
		if (armorItem != null)
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_dented_armor_effect"));
	}

	q.onQueryTooltip = @(__original) function( _skill, _tooltip )
	{
		__original(_skill, _tooltip);
		if (this.m.DentArmorSkills.find(_skill.getID()) != null)
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Applies the [Dented Armor|Skill+rf_dented_armor_effect] effect on hitting an armor piece with at least " + this.m.MinArmorToDent + " maximum durability")
			});
		}
	}

	q.onAdded = @(__original) function()
	{
		__original();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null) this.onEquip(weapon);
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
