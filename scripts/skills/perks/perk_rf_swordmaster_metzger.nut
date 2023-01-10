this.perk_rf_swordmaster_metzger <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {},
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
			if (!this.getContainer().getActor().getMainhandItem().isItemType(::Const.Items.ItemType.RF_Southern))
				return false;
		}

		return ret;
	}

	function onAdded()
	{
		local equippedItem = this.getContainer().getActor().getMainhandItem();
		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}

		if (this.m.IsNew)
		{
			local perkTree = this.getContainer().getActor().getBackground().getPerkTree();

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

		_item.addSkill(::new("scripts/skills/actives/decapitate"));

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
		this.getContainer().removeByStackByID("perk.rf_sanguinary", false);
		this.getContainer().removeByStackByID("perk.perk_rf_bloodbath", false);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || !this.isEnabled()) return;

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			local actor = this.getContainer().getActor();
			local effect = ::new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(10);

			_targetEntity.getSkills().add(effect);
		}
	}
});
