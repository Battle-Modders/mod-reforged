::Reforged.HooksMod.hook("scripts/entity/world/world_entity", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.getFlags().set("RF_SpawnDay", ::World.getTime().Days);
	}}.create;

	q.onCombatStarted = @(__original) { function onCombatStarted()
	{
		__original();
		this.getFlags().increment("RF_NumCombats");
	}}.onCombatStarted;

	q.clearTroops = @(__original) { function clearTroops()
	{
		__original();
		this.getFlags().remove("RF_Spawnlist");
	}}.clearTroops;

	// Contracts that target this entity and are known to the player.
	q.RF_getKnownContractsTooltip <- { function RF_getKnownContractsTooltip()
	{
		local knownContractsEntries = [];
		foreach (c in ::World.Contracts.RF_getKnownContracts())
		{
			if (::MSU.isEqual(c.getHome(), this))
				continue;

			foreach (d in c.RF_getDestinations())
			{
				if (::MSU.isEqual(this, d))
				{
					knownContractsEntries.push({
						id = 200, type = "hint", icon = c.RF_getTooltipIcon(),
						text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(c, "func:RF_getTooltip,contentType:settlement-status-effect"))
					});
					break;
				}
			}
		}

		if (knownContractsEntries.len() != 0)
		{
			return [{
				id = 200, type = "hint", icon = "ui/icons/contract_scroll.png",
				text = ::World.Retinue.hasFollower("follower.agent") ? "Relevant contracts" : "Known relevant contracts",
				children = knownContractsEntries
			}];
		}

		return [];
	}}.RF_getKnownContractsTooltip;

	q.RF_addDevSpawnInfo <- { function RF_addDevSpawnInfo( _tooltip )
	{
		// Add Cost/Strength to the tooltip if the associated mod setting is enabled.
		if (!this.isHiddenToPlayer() && this.m.Troops.len() != 0)
		{
			local cost = 0;
			local strength = 0;
			foreach (t in this.m.Troops)
			{
				cost += ::Const.World.Spawn.RF_ScriptToTroopMap[t.Script].Cost;
				strength += t.Strength;
			}
			_tooltip.push({
				id = 100,
				type = "hint",
				icon = "ui/icons/icon_contract_swords.png",
				text = format("Cost / Strength / Combats: %i / %i / %i", cost.tointeger(), strength.tointeger(), this.getFlags().has("RF_NumCombats") ? this.getFlags().get("RF_NumCombats") : 0)
			});
			_tooltip.push({
				id = 101,
				type = "hint",
				icon = "ui/icons/action_points.png",
				text = format("Spawned on Day: %i", this.getFlags().has("RF_SpawnDay") ? this.getFlags().get("RF_SpawnDay") : 0)
			});

			local spawnListID;
			if (this.getFlags().has("RF_Spawnlist"))
			{
				spawnListID = this.getFlags().get("RF_Spawnlist");
			}
			else if (this.isLocation() && this.m.DefenderSpawnList != null)
			{
				foreach (id, s in ::Const.World.Spawn)
				{
					if (s == this.m.DefenderSpawnList)
					{
						spawnListID = id;
						break;
					}
				}
			}
			if (spawnListID != null)
			{
				_tooltip.push({
					id = 102,	type = "hint",	icon = "ui/icons/special.png",
					text = "Spawnlist: " + spawnListID
				});
			}
		}
	}}.RF_addDevSpawnInfo;
});

::Reforged.HooksMod.hookTree("scripts/entity/world/world_entity", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		if (this.getFaction() == 0)
			return ret;

		// Add any known contracts related to this world entity to its tooltip.
		ret.extend(this.RF_getKnownContractsTooltip())

		if (!::Reforged.Mod.ModSettings.getSetting("Dev_SpawnsInfo").getValue())
		{
			this.RF_addDevSpawnInfo(ret);
		}

		return ret;
	}}.getTooltip;
});
