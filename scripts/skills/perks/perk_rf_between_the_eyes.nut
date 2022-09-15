this.perk_rf_between_the_eyes <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_between_the_eyes";
		this.m.Name = ::Const.Strings.PerkName.RF_BetweenTheEyes;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BetweenTheEyes;
		this.m.Icon = "ui/perks/rf_between_the_eyes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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

	function onEquip( _item )
	{
		if (_item.getSlotType() == ::Const.ItemSlot.Mainhand && _item.isItemType(::Const.Items.ItemType.MeleeWeapon) && this.getContainer().getAttackOfOpportunity() != null)
		{
			_item.addSkill(::new("scripts/skills/actives/rf_between_the_eyes_skill"));
		}
	}
});

