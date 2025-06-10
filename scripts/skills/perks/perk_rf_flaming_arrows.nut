this.perk_rf_flaming_arrows <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_flaming_arrows";
		this.m.Name = ::Const.Strings.PerkName.RF_FlamingArrows;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FlamingArrows;
		this.m.Icon = "ui/perks/perk_rf_flaming_arrows.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		local equippedItem = this.getContainer().getActor().getMainhandItem();
		if (equippedItem != null)
			this.onEquip(equippedItem);
	}

	function onRemoved()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			foreach (s in weapon.m.SkillPtrs)
			{
				if (s.getID() == "actives.flaming_arrows")
				{
					weapon.removeSkill(s);
					break;
				}
			}
		}
	}

	function onEquip( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Weapon) && _item.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			_item.addSkill(::new("scripts/skills/actives/rf_flaming_arrows_skill"));
		}
	}
});
