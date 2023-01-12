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
		return this.m.IsSpent || !this.getContainer().getActor().isPlacedOnMap() || !this.isEnabled();
	}

	function getItemActionCost( _items )
	{
		if (this.m.IsSpent)
			return null;

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

	function onPayForItemAction( _skill, _items )
	{
		if (_skill == null || _skill.getID() != "perk.rf_target_practice")
		{
			this.m.IsSpent = true;
		}
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();

		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.OneHanded) ||
			(!weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) && !weapon.isWeaponType(::Const.Items.WeaponType.Throwing)))
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

	function onUpdate( _properties )
	{
		if (!this.isEnabled() || ::MSU.isKindOf(this.getContainer().getActor(), "player"))
			return;

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

	function onEquip( _item )
	{
		local actor = this.getContainer().getActor();
		if (_item.getSlotType() != ::Const.ItemSlot.Mainhand || !this.isEnabled() || !::MSU.isKindOf(actor, "player") || actor.getBackground() == null)
			return;

		local perkTree = actor.getBackground().getPerkTree();
		if (perkTree != null)
		{
			foreach (id in this.m.MasteryIDs)
			{
				if (perkTree.hasPerk(id))
				{
					local script = "scripts/skills/perks/" + ::String.replace(id, ".", "_");
					this.getContainer().add(::MSU.new(script, function(o) {
						o.m.IsSerialized = false;
						o.m.IsRefundable = false;
					}));
				}
			}
		}
	}

	function onUnequip( _item )
	{
		local actor = this.getContainer().getActor();
		if (_item.getSlotType() != ::Const.ItemSlot.Mainhand || !this.isEnabled() || !::MSU.isKindOf(actor, "player") || actor.getBackground() == null)
			return;

		local perkTree = actor.getBackground().getPerkTree();
		if (perkTree != null)
		{
			foreach (id in this.m.MasteryIDs)
			{
				if (perkTree.hasPerk(id)) this.getContainer().removeByStackByID(id, false);
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
