this.perk_rf_weapon_master <- ::inherit("scripts/skills/skill", {
	m = {
		PerksAdded = []
	},
	function create()
	{
		this.m.ID = "perk.rf_weapon_master";
		this.m.Name = ::Const.Strings.PerkName.RF_WeaponMaster;
		this.m.Description = "This character is skilled in the use of various weapons."
		this.m.Icon = "ui/perks/rf_weapon_master.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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

	function onEquip( _item )
	{
		if (!_item.isItemType(::Const.Items.ItemType.Weapon))
			return;

		local hasFirstPerk = false;
		local hasSecondPerk = false;
		local hasThirdPerk = false;

		foreach (groupID in ::DynamicPerks.PerkGroupCategories.findById("pgc.rf_weapon").getGroups())
		{
			foreach (i, row in ::DynamicPerks.PerkGroups.findById(groupID).getTree())
			{
				if (row.len() == 0)
					continue;

				local perkID = row[0];
				if (!this.getContainer().hasSkill(perkID))
						continue;

				if (i < 3)
					hasFirstPerk = true;
				else if (i == 3)
					hasSecondPerk = true;
				else
					hasThirdPerk = true;
			}
		}

		if (!hasFirstPerk && !hasSecondPerk && !hasThirdPerk)
			return;

		local pg;
		local perkTree = this.getContainer().getActor().getPerkTree();

		if (_item.isItemType(::Const.Items.ItemType.RangedWeapon))
		{
			if (_item.isWeaponType(::Const.Items.WeaponType.Bow) && perkTree.hasPerkGroup("pg.rf_bow"))					pg = "pg.rf_bow";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Crossbow) && perkTree.hasPerkGroup("pg.rf_crossbow"))	pg = "pg.rf_crossbow";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Firearm) && perkTree.hasPerkGroup("pg.rf_crossbow"))	pg = "pg.rf_crossbow";
		}
		else
		{
			if (_item.isWeaponType(::Const.Items.WeaponType.Axe) && perkTree.hasPerkGroup("pg.rf_axe")) 				pg = "pg.rf_axe";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Cleaver) && perkTree.hasPerkGroup("pg.rf_cleaver"))	pg = "pg.rf_cleaver";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Dagger) && perkTree.hasPerkGroup("pg.rf_dagger"))		pg = "pg.rf_dagger";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Flail) && perkTree.hasPerkGroup("pg.rf_flail"))		pg = "pg.rf_flail";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Hammer) && perkTree.hasPerkGroup("pg.rf_hammer"))		pg = "pg.rf_hammer";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Mace) && perkTree.hasPerkGroup("pg.rf_mace"))			pg = "pg.rf_mace";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Polearm) && perkTree.hasPerkGroup("pg.rf_polearm"))	pg = "pg.rf_polearm";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Spear) && perkTree.hasPerkGroup("pg.rf_spear"))		pg = "pg.rf_spear";
			else if (_item.isWeaponType(::Const.Items.WeaponType.Sword) && perkTree.hasPerkGroup("pg.rf_sword"))		pg = "pg.rf_sword";
		}

		if (pg == null)
			return;

		foreach (i, row in ::DynamicPerks.PerkGroups.findById(pg).getTree())
		{
			if (row.len() == 0 || (i < 3 && !hasFirstPerk) || (i == 3 && !hasSecondPerk) || (i > 3 && !hasThirdPerk))
				continue;

			local perkID = row[0];

			this.m.PerksAdded.push(perkID);
			this.getContainer().add(::MSU.new(::Const.Perks.findById(perkID).Script, function(o) {
				o.m.IsSerialized = false;
				o.m.IsRefundable = false;
			}));
		}
	}

	function onUnequip( _item )
	{
		if (!_item.isItemType(::Const.Items.ItemType.Weapon))
			return;

		foreach (perkID in this.m.PerksAdded)
		{
			this.getContainer().removeByStackByID(perkID, false);
		}

		this.m.PerksAdded.clear();
	}
});

