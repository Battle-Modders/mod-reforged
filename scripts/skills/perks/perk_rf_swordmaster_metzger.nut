this.perk_rf_swordmaster_metzger <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {
		IsCleaverWeaponTypeAdded = false
	},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_metzger";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterMetzger;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterMetzger;
		this.m.Icon = "ui/perks/rf_swordmaster_metzger.png";
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		local ret = this.perk_rf_swordmaster_abstract.isEnabled();
		if (ret)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			// If it's neither a southern sword nor a sword/cleaver hybrid
			if (!weapon.isItemType(::Const.Items.ItemType.RF_Southern) && !weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
				return false;
		}

		return ret;
	}

	function onAdded()
	{
		local equippedItem = this.getContainer().getActor().getMainhandItem();
		if (equippedItem != null) this.onEquip(equippedItem);

		if (this.m.IsNew && ::MSU.isKindOf(this.getContainer().getActor(), "player"))
		{
			local perkTree = this.getContainer().getActor().getPerkTree();

			perkTree.addPerkGroup("pg.rf_cleaver");
			perkTree.removePerk("perk.mastery.cleaver");
			perkTree.removePerk("perk.rf_swordlike");
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
		if (!this.isEnabled() || _item.getSlotType() != ::Const.ItemSlot.Mainhand) return;

		_item.addSkill(::MSU.new("scripts/skills/actives/decapitate", function(o) {
			o.m.DirectDamageMult = _item.m.DirectDamageMult;
		}));
		if (!_item.isWeaponType(::Const.Items.WeaponType.Cleaver))
		{
			_item.m.WeaponType = _item.m.WeaponType | ::Const.Items.WeaponType.Cleaver;
			this.m.IsCleaverWeaponTypeAdded = true;
		}

		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_sanguinary", function(o) {
			o.m.IsSerialized = false;
			o.m.IsRefundable = false;
		}));

		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_bloodbath", function(o) {
			o.m.IsSerialized = false;
			o.m.IsRefundable = false;
		}));
	}

	function onUnequip( _item )
	{
		if (!this.isEnabled() || _item.getSlotType() != ::Const.ItemSlot.Mainhand)
			return;

		this.getContainer().removeByStackByID("perk.rf_sanguinary", false);
		this.getContainer().removeByStackByID("perk.rf_bloodbath", false);
		if (this.m.IsCleaverWeaponTypeAdded)
		{
			_item.m.WeaponType -= ::Const.Items.WeaponType.Cleaver;
			this.m.IsCleaverWeaponTypeAdded = false;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _skill.getID() == "actives.cleave" || !this.isEnabled())
			return;

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			local actor = this.getContainer().getActor();
			local effect = ::new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(10);

			_targetEntity.getSkills().add(effect);
		}
	}
});
