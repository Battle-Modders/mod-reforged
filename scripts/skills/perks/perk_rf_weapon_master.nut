this.perk_rf_weapon_master <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		MasteryIDs = [
			"perk.mastery.axe",
			"perk.mastery.cleaver",
			"perk.mastery.dagger",
			"perk.mastery.flail",
			"perk.mastery.hammer",
			"perk.mastery.mace",
			"perk.mastery.spear",
			"perk.mastery.sword",
			"perk.mastery.throwing"
		]
	},
	function create()
	{
		this.m.ID = "perk.rf_weapon_master";
		this.m.Name = ::Const.Strings.PerkName.RF_WeaponMaster;
		this.m.Description = "This character is a master of One-Handed weapons and can swap one such weapon for another for free once per turn."
		this.m.Icon = "ui/perks/rf_weapon_master.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.ItemActionOrder = ::Const.ItemActionOrder.BeforeLast;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		return this.m.IsSpent || !actor.isPlacedOnMap() || !this.isEnabled();
	}

	function getItemActionCost(_items)
	{
		if (this.m.IsSpent)
		{
			return null;
		}

		local oneHandedCount = 0;

		foreach (item in _items)
		{
			if (item == null || item.getSlotType() != ::Const.ItemSlot.Mainhand || item.isItemType(::Const.Items.ItemType.TwoHanded) || (!item.isItemType(::Const.Items.ItemType.MeleeWeapon) && !item.isWeaponType(::Const.Items.WeaponType.Throwing)))
			{
				continue;
			}

			if (item.isItemType(::Const.Items.ItemType.OneHanded))
			{
				oneHandedCount++;
			}
		}

		if (oneHandedCount > 0)
		{
			return 0;
		}

		return null;
	}

	function onPayForItemAction(_skill, _items)
	{
		if (_skill != null && _skill.getID() != "perk.rf_target_practice")
		{
			this.m.IsSpent = true;
		}
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();

		if (weapon == null ||
			!weapon.isItemType(::Const.Items.ItemType.OneHanded) ||
			(!weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) && !weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
		)
		{
			return false;
		}

		foreach (skill in this.m.MasteryIDs)
		{
			if (this.getContainer().hasSkill(skill)) return true;
		}

		foreach (skill in this.getContainer().m.SkillsToAdd)
		{
			if (!skill.isGarbage() && this.m.MasteryIDs.find(skill.getID()) != null) return true;
		}

		return false;
	}

	function onAdded()
	{
		local equippedItem = this.getContainer().getActor().getMainhandItem();
		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}
	}

	function onRemoved()
	{
		local equippedItem = this.getContainer().getActor().getMainhandItem();
		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}
	}

	function onEquip( _item )
	{
		if (!this.isEnabled()) return;

		local addNonSerializedPerk = function( _script )
		{
			local perk = ::new(_script);
			foreach (skill in this.m.MasteryIDs)
			{
				if (this.getContainer().hasSkill(perk.getID())) return;
			}

			foreach (skill in this.getContainer().m.SkillsToAdd)
			{
				if (!skill.isGarbage() && skill.getID() == perk.getID()) return;
			}

			perk.m.IsSerialized = false;
			_item.addSkill(perk);
		}

		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled())
		{
			if (::MSU.isKindOf(actor, "player") && actor.getBackground() != null)
			{
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecAxe)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_axe");
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecCleaver)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_cleaver");
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecDagger)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_dagger");
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecFlail)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_flail");
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecHammer)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_hammer");
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecMace)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_mace");
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecSpear)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_spear");
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecSword)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_sword");
				if (actor.getBackground().hasPerk(::Const.Perks.PerkDefs.SpecThrowing)) addNonSerializedPerk("scripts/skills/perks/perk_mastery_throwing");
			}
		}
		else
		{
			if (!::MSU.isKindOf(actor, "player") || actor.getBackground() == null)
			{
				_properties.IsSpecializedInAxes = true;
				_properties.IsSpecializedInCleavers = true;
				_properties.IsSpecializedInDaggers = true;
				_properties.IsSpecializedInFlails = true;
				_properties.IsSpecializedInHammers = true;
				_properties.IsSpecializedInMaces = true;
				_properties.IsSpecializedInSpears = true;
				_properties.IsSpecializedInSwords = true;
				_properties.IsSpecializedInThrowing = true;
			}
		}
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = false;
	}
});
