::Reforged.Items <- {
	AnatomistPotions = {
		// Key: EntityType
		// Value: Table { AcquiredFlagName, DiscoveredFlagName, ShouldDropFlagName, ItemScript, EffectScript, ResearchNotesScript }
		Infos = {
			[::Const.EntityType.RF_Banshee] = {
				AcquiredFlagName = "RF_isBansheePotionAcquired",
				DiscoveredFlagName = "RF_isBansheePotionDiscovered",
				ShouldDropFlagName = "RF_shouldDropBansheePotion",
				ItemScript = "scripts/items/misc/anatomist/rf_banshee_potion_item",
				EffectScript = "scripts/skills/effects/rf_banshee_potion_effect",
				ResearchNotesScript = "scripts/items/misc/anatomist/research_notes_undead_item"
			}
		},

		function getInfo( _obj )
		{
			if (typeof _obj == "integer") // EntityType
			{
				return this.Infos[_obj];
			}
			else if (::MSU.isKindOf(_obj, "rf_anatomist_potion_effect"))
			{
				local path = ::IO.scriptFilenameByHash(_obj);
				foreach (info in this.Infos)
				{
					if (info.EffectScript == path)
						return info;
				}
			}

			throw ::MSU.Exception.KeyNotFound(_obj);
		}
	}

	function isDuelistValid( _weapon )
	{
		if (!_weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
			return false;

		local function isSkillValid( _skill )
		{
			return _skill.getBaseValue("ActionPointCost") <= 4 && _skill.isDuelistValid();
		}

		if (_weapon.isEquipped())
			return isSkillValid(_weapon.getContainer().getActor().getSkills().getAttackOfOpportunity());

		local copy = ::new(::IO.scriptFilenameByHash(_weapon.ClassNameHash));
		local player = ::MSU.getDummyPlayer();
		player.getItems().equip(copy);
		local ret = isSkillValid(player.getSkills().getAttackOfOpportunity());
		player.getItems().unequip(copy);
		return ret;
	}

	// This function is used to get the skills of an item that one gets from equipping the item.
	function getSkills( _item )
	{
		local data = ::MSU.Class.SerializationData();
		_item.onSerialize(data.getSerializationEmulator());

		local cloneItem = ::new(::IO.scriptFilenameByHash(_item.ClassNameHash));
		cloneItem.onDeserialize(data.getDeserializationEmulator());

		local container = ::MSU.getDummyPlayer().getItems();
		local existingItem = container.getItemAtSlot(cloneItem.getSlotType());
		if (existingItem != null)
		{
			container.unequip(existingItem);
		}

		container.equip(cloneItem);
		local ret = cloneItem.getSkills();
		container.unequip(cloneItem);

		if (existingItem != null)
		{
			container.equip(existingItem);
		}

		// Set the item of the skills to the original _item
		// because cloneItem will become null at the end of this function
		// and skill.m.Item is kept as a WeakTableRef.
		foreach (s in ret)
		{
			s.setItem(_item);
		}

		return ret;
	}
};

// Automatic hooks on all the research notes items to add tooltips to them
// based on the info in ::Reforged.Items.AnatomistPotions.Infos.
local notesToEntityTypesMap = {};
foreach (entityType, info in ::Reforged.Items.AnatomistPotions.Infos)
{
	if (!(info.ResearchNotesScript in notesToEntityTypesMap))
	{
		notesToEntityTypesMap[info.ResearchNotesScript] <- [];
	}

	notesToEntityTypesMap[info.ResearchNotesScript].push(entityType);
}

foreach (notesScript, _ in notesToEntityTypesMap)
{
	::Reforged.HooksMod.hook(notesScript, function(q) {
		q.getTooltip = @(__original) { function getTooltip()
		{
			local ret = __original();
			foreach (entityType in notesToEntityTypesMap[::IO.scriptFilenameByHash(this.ClassNameHash)])
			{
				local info = ::Reforged.Items.AnatomistPotions.getInfo(entityType);
				if (::World.Statistics.getFlags().get(info.DiscoveredFlagName))
				{
					ret.push({
						id = 15,
						type = "text",
						icon = "ui/icons/special.png",
						text = "" + ::Const.Strings.EntityName[entityType] + ": " + ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedItemName(::new(info.PotionScript)))
					});
				}
				else
				{
					ret.push({
						id = 15,
						type = "text",
						icon = "ui/icons/special.png",
						text = "" + ::Const.Strings.EntityName[entityType] + ": ???"
					});
				}
			}
			return ret;
		}}.getTooltip;
	});
}
