this.perk_rf_weapon_master <- ::inherit("scripts/skills/skill", {
	m = {
		PerksAdded = [],
		RestrictToGroupsInPerkTree = false
	},
	function create()
	{
		this.m.ID = "perk.rf_weapon_master";
		this.m.Name = ::Const.Strings.PerkName.RF_WeaponMaster;
		this.m.Description = "This character is skilled in the use of various weapons."
		this.m.Icon = "ui/perks/perk_rf_weapon_master.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
	}

	function __getTrueAddedPerks()
	{
		// exclude perks that were already present (i.e. not granted by Weapon Master)
		return this.m.PerksAdded.filter(@(_, _perk) !_perk.isSerialized());
	}

	function isHidden()
	{
		return this.__getTrueAddedPerks().len() == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local perks = this.__getTrueAddedPerks();
		if  (perks.len() != 0)
		{
			local container = this.getContainer();
			local extraData = "entityId:" + container.getActor().getID();
			local perkIcons = perks
								.map(@(_perk) ::Reforged.NestedTooltips.getNestedPerkImage(_perk, extraData))
								.reduce(@(_a, _b) _a + _b);

			ret.push({
				id = 10,	type = "text",	icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("[Perks|Concept.Perk] gained:\n" + perkIcons)
			});
		}

		return ret;
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
					// Don't add a perk which we already added (relevant when not removing perks during battle)
					foreach (p in this.m.PerksAdded)
					{
						if (p.getID() == perkID)
							continue;
					}
					local perk = ::Reforged.new(::Const.Perks.findById(perkID).Script, function(o) {
						o.m.IsSerialized = false;
						o.m.IsRefundable = false;
					});
					this.getContainer().add(perk);
					// Need to do it like this because of Stack Based Skills which will throw away the perk above
					// if a perk with the same ID already exists on the bro.
					local existingPerk = this.getContainer().getSkillByID(perkID);
					this.m.PerksAdded.push(::MSU.asWeakTableRef(existingPerk == null ? perk : existingPerk));
					break;
				}
			}
		}

		local actor = this.getContainer().getActor();
		local perkTree = ::MSU.isKindOf(actor, "player") ? actor.getPerkTree() : null;
		local allWeaponPGs = []; // Contains all weapon PGs that are present in this character's perk tree
		local equippedweaponPGs = []; // Contains the PGs of this equipped weapon

		foreach (weaponTypeName, weaponType in ::Const.Items.WeaponType)
		{
			if (weaponTypeName == "Firearm")
				weaponTypeName = "Crossbow";

			local pg = ::DynamicPerks.PerkGroups.findById("pg.rf_" + weaponTypeName.tolower());
			if (pg == null)
				continue;

			if (perkTree == null || perkTree.hasPerkGroup(pg.getID()))
			{
				allWeaponPGs.push(pg);
			}

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

		// Remove all tierRanges which are invalid i.e. in which we haven't learned any weapon perk
		for (local i = tierRanges.len() - 1; i >= 0; i--)
		{
			local range = tierRanges[i];
			local isValid = false;
			foreach (pg in allWeaponPGs)
			{
				if (hasPerkFromGroup(pg, range[0], range[1]))
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

		// Restrict us only to the perk groups that exist in this character's perk tree and
		// add perks from all such equippedWeaponPGs in the valid tierRanges
		if (this.m.RestrictToGroupsInPerkTree && perkTree != null)
		{
			equippedweaponPGs = equippedweaponPGs.filter(@(_, _pg) perkTree.hasPerkGroup(_pg.getID()));
		}

		foreach (range in tierRanges)
		{
			foreach (pg in equippedweaponPGs)
			{
				addPerkFromGroup(pg, range[0], range[1]);
			}
		}
	}

	function onUnequip( _item )
	{
		if (!_item.isItemType(::Const.Items.ItemType.Weapon))
			return;

		// Don't remove perks during battle. This prevents perks from losing state e.g. cooldown, or other effects.
		if (!::Tactical.isActive())
		{
			this.removePerks();
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.removePerks();
	}

	function removePerks()
	{
		foreach (perk in this.m.PerksAdded)
		{
			this.getContainer().removeByStackByID(perk.getID(), false);
		}

		this.m.PerksAdded.clear();
	}
});
