::mods_hookNewObjectOnce("ui/screens/tooltip/tooltip_events", function(o) {
	local tactical_queryTileTooltipData = o.tactical_queryTileTooltipData;
	o.tactical_queryTileTooltipData = function()
	{
		local ret = tactical_queryTileTooltipData();
		local lastTileHovered = ::Tactical.State.getLastTileHovered();
		if (ret != null && lastTileHovered.IsCorpseSpawned && ::Tactical.TurnSequenceBar.getActiveEntity() != null && lastTileHovered.IsDiscovered && lastTileHovered.IsVisibleForPlayer)
		{
			local actor = ::Tactical.TurnSequenceBar.getActiveEntity();
			if (actor.isPlacedOnMap() && actor.isPlayerControlled())
			{
				local opportunist = actor.getSkills().getSkillByID("perk.rf_opportunist");
				if (opportunist != null && opportunist.canProcOntile(lastTileHovered))
				{
					ret.push({
						id = 90,
						type = "text",
						icon = "ui/perks/rf_opportunist.png"
						text = "Can be used for " + ::MSU.Text.colorGreen(opportunist.getName())
					});
				}
			}
		}

		return ret;
	}
});
