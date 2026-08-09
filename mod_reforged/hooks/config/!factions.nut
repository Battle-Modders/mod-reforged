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
		// No alliances
	],
	[
		"music/rf_draugr_1.ogg",
		"music/rf_draugr_2.ogg"
	]
);

local allies = array(100);
for (local i = 0; i < 100; i++) {
    allies[i] = i;
}
// I couldnt make combat simulator custom factions work here
// allies.extend(["faction-0","faction-1","faction-2","faction-3"])
addFaction("RF_Beckoned",::createColor("#444444"),"bust_base_beasts",[],
	allies,
	[])