this.perk_rf_weapon_master <- ::inherit("scripts/skills/skill", {
	m = {
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
		this.m.Description = "This character is a master of One-Handed weapons."
		this.m.Icon = "ui/perks/rf_weapon_master.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null) this.onEquip(weapon);
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

	function getWeaponSpecificPerkID( _weaponType )
	{
		switch (_weaponType)
		{
			case ::Const.Items.WeaponType.Axe: return "perk.rf_cull";
			case ::Const.Items.WeaponType.Cleaver: return "perk.rf_bloodlust";
			case ::Const.Items.WeaponType.Dagger: return "perk.rf_swift_stabs";
			case ::Const.Items.WeaponType.Flail: return "perk.rf_whirling_death";
			case ::Const.Items.WeaponType.Hammer: return "perk.rf_dent_armor";
			case ::Const.Items.WeaponType.Mace: return "perk.rf_bone_breaker";
			case ::Const.Items.WeaponType.Spear: return "perk.rf_two_for_one";
			case ::Const.Items.WeaponType.Sword: return "perk.rf_en_garde";
			case ::Const.Items.WeaponType.Throwing: return "perk.rf_nailed_it";
		}

		return "";
	}

	function onEquip( _item )
	{
		local actor = this.getContainer().getActor();
		if (_item.getSlotType() != ::Const.ItemSlot.Mainhand || !this.isEnabled())
			return;

		if (::MSU.isKindOf(actor, "player"))
		{
			local perkTree = actor.getPerkTree();
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

			foreach (weaponType in ::Const.Items.WeaponType)
			{
				local perkID = this.getWeaponSpecificPerkID(weaponType);
				if (_item.isWeaponType(weaponType) && perkTree.hasPerk(perkID))
				{
					this.getContainer().add(::MSU.new("scripts/skills/perks/" + ::String.replace(perkID, ".", "_"), function(o) {
						o.m.IsSerialized = false;
						o.m.IsRefundable = false;
					}))
				}
			}
		}
		else
		{
			foreach (weaponType in ::Const.Items.WeaponType)
			{
				local perkID = this.getWeaponSpecificPerkID(weaponType);
				if (_item.isWeaponType(weaponType))
				{
					this.getContainer().add(::MSU.new("scripts/skills/perks/" + ::String.replace(perkID, ".", "_"), function(o) {
						o.m.IsSerialized = false;
						o.m.IsRefundable = false;
					}))
				}
			}
		}
	}

	function onUnequip( _item )
	{
		local actor = this.getContainer().getActor();
		if (_item.getSlotType() != ::Const.ItemSlot.Mainhand || !this.isEnabled())
			return;

		if (::MSU.isKindOf(actor, "player"))
		{
			local perkTree = actor.getPerkTree();
			foreach (id in this.m.MasteryIDs)
			{
				if (perkTree.hasPerk(id)) this.getContainer().removeByStackByID(id, false);
			}
			foreach (weaponType in ::Const.Items.WeaponType)
			{
				local perkID = this.getWeaponSpecificPerkID(weaponType);
				if (perkTree.hasPerk(perkID)) this.getContainer().removeByStackByID(perkID, false);
			}
		}
		else
		{
			foreach (weaponType in ::Const.Items.WeaponType)
			{
				this.getContainer().removeByStackByID(this.getWeaponSpecificPerkID(weaponType), false);
			}
		}
	}
});
