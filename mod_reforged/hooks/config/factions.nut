local highest = 0;
foreach (v in ::Const.FactionTrait)
{
	if (typeof v == "integer" && v > highest)
	{
		highest = v;
	}
}

local function addFaction( _key, _color, _base, _actions, _alliance, _battleTracks )
{
	::Const.FactionType[_key] <- ::Const.FactionType.COUNT;
	::Const.FactionType.COUNT++;

	::Const.Faction[_key] <- ::Const.Faction.COUNT;
	::Const.Faction.COUNT++;

	::Const.FactionColor.push(_color);

	::Const.FactionBase.push(_base);

	::Const.FactionAlliance.push(_alliance);

	::Const.FactionTrait[_key] <- ++highest;
	::Const.FactionTrait.Actions.push(_actions);

	::Const.Music.BattleTracks.push(_battleTracks);
}

addFaction(
	"RF_Draugr",
	::createColor("#bd00c4"),
	"bust_base_rf_draugr_01",
	[
		"scripts/factions/actions/rf_build_draugr_camp_action",
		// "scripts/factions/actions/rf_send_draugr_roamers_action"
	],
	[
		::Const.Faction.Zombies,
		::Const.Faction.Beasts,
		::Const.Faction.Undead
	],
	[
		"music/rf_draugr_1.ogg",
		"music/rf_draugr_2.ogg"
	]
);
