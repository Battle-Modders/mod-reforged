this.perk_rf_weapon_master <- ::inherit("scripts/skills/skill", {
	m = {
		OldPerks = [], // Contains perks stored temporarily during battle while swapping a weapon
		PerksAdded = []
	},
	function create()
	{
		this.m.ID = "perk.rf_weapon_master";
		this.m.Name = ::Const.Strings.PerkName.RF_WeaponMaster;
		this.m.Description = "This character is skilled in the use of various weapons."
		this.m.Icon = "ui/perks/perk_rf_weapon_master.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
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

	// onUnequip and onEquip run before paying for item action cost
	// so we remove old perks after that entire thing is complete
	function onPayForItemAction( _skill, _items )
	{
		this.removeOldPerks();
	}

	function onEquip( _item )
	{
		if (!_item.isItemType(::Const.Items.ItemType.Weapon))
			return;

		this.m.PerksAdded.clear();

		local function hasSkill( _id )
		{
			if (this.getContainer().hasSkill(_id))
				return true;

			foreach (s in this.getContainer().m.SkillsToAdd)
			{
				if (s.getID() == _id && !s.isGarbage())
					return true;
			}

			return false;
		}

		// Returns true if a bro has at least 1 perk from the given group in the given tier range
		local function hasPerkFromGroup( _group, _tierStart, _tierEnd )
		{
			local tree = _group.getTree();
			for (local i = _tierStart - 1; i < _tierEnd; i++)
			{
				foreach (perkID in tree[i])
				{
					if (hasSkill(perkID))
						return true;
				}
			}
			return false;
		}

		// Adds to the bro the first perk it finds in the given group in the given tier range
		local function addPerkFromGroup( _group, _tierStart, _tierEnd )
		{
			local tree = _group.getTree();
			for (local i = _tierStart - 1; i < _tierEnd; i++)
			{
				local row = tree[i];
				if (row.len() != 0)
				{
					local perkID = row[0];
					this.m.PerksAdded.push(perkID);
					this.getContainer().add(::Reforged.new(::Const.Perks.findById(perkID).Script, function(o) {
						o.m.IsSerialized = false;
						o.m.IsRefundable = false;
					}));
					break;
				}
			}
		}

		local allWeaponPGs = [];
		local equippedweaponPGs = [];

		foreach (weaponTypeName, weaponType in ::Const.Items.WeaponType)
		{
			if (weaponTypeName == "Firearm")
				weaponTypeName = "Crossbow";

			local pg = ::DynamicPerks.PerkGroups.findById("pg.rf_" + weaponTypeName.tolower());
			if (pg == null)
				continue;

			allWeaponPGs.push(pg);

			if (_item.isWeaponType(weaponType) && equippedweaponPGs.find(pg) == null)
			{
				equippedweaponPGs.push(pg);
			}
		}

		local tierRanges = [
			[1, 3],
			[4, 4]
		];

		if (equippedweaponPGs.len() == 1)
		{
			tierRanges.push([5, 7]); // The third perk is only granted if you are using a non-hybrid weapon
		}

		local perkTree = this.getContainer().getActor().getPerkTree();

		// Remove all tierRanges which are invalid i.e. in which we haven't learned any weapon perk
		for (local i = tierRanges.len() - 1; i >= 0; i--)
		{
			local range = tierRanges[i];
			local isValid = false;
			foreach (pg in allWeaponPGs)
			{
				if (perkTree.hasPerkGroup(pg.getID()) && hasPerkFromGroup(pg, range[0], range[1]))
				{
					isValid = true;
					break;
				}
			}
			if (!isValid)
			{
				tierRanges.remove(i);
			}
		}

		// Add perks from all equippedWeaponPGs in the valid tierRanges
		foreach (range in tierRanges)
		{
			foreach (pg in equippedweaponPGs)
			{
				if (!hasPerkFromGroup(pg, range[0], range[1]))
				{
					addPerkFromGroup(pg, range[0], range[1]);
				}
			}
		}
	}

	function onUnequip( _item )
	{
		if (!_item.isItemType(::Const.Items.ItemType.Weapon))
			return;

		if (::Tactical.isActive())
		{
			this.m.OldPerks = clone this.m.PerksAdded;
		}
		else
		{
			this.removePerks();
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.removeOldPerks();
	}

	function removePerks()
	{
		foreach (perkID in this.m.PerksAdded)
		{
			this.getContainer().removeByStackByID(perkID, false);
		}

		this.m.PerksAdded.clear();

		this.removeOldPerks();
	}

	function removeOldPerks()
	{
		foreach (perkID in this.m.OldPerks)
		{
			this.getContainer().removeByStackByID(perkID, false);
		}

		this.m.OldPerks.clear();
	}
});
