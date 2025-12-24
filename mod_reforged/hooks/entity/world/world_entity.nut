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
});

::Reforged.HooksMod.hookTree("scripts/entity/world/world_entity", function(q) {
	// Add Cost/Strength to the tooltip if the associated mod setting is enabled.
	q.getTooltip = @(__original) { function getTooltip()
	{
		if (!::Reforged.Mod.ModSettings.getSetting("Dev_SpawnsInfo").getValue())
			return __original();

		local ret = __original();
		if (!this.isHiddenToPlayer() && this.m.Troops.len() != 0 && this.getFaction() != 0)
		{
			local cost = 0;
			local strength = 0;
			foreach (t in this.m.Troops)
			{
				cost += t.Cost;
				strength += t.Strength;
			}
			ret.push({
				id = 100,
				type = "hint",
				icon = "ui/icons/icon_contract_swords.png",
				text = format("Cost / Strength / Combats: %i / %i / %i", cost.tointeger(), strength.tointeger(), this.getFlags().has("RF_NumCombats") ? this.getFlags().get("RF_NumCombats") : 0)
			});
			ret.push({
				id = 101,
				type = "hint",
				icon = "ui/icons/action_points.png",
				text = format("Spawned on Day: %i", this.getFlags().has("RF_SpawnTime") ? this.getFlags().get("RF_SpawnDay") : 0)
			});
		}
		return ret;
	}}.getTooltip;
});
