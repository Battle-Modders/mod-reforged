// Vanilla Adjustments
::MSU.Array.removeValues(::Const.Strings.CrossbowNames, [
	"Betrayer"		// moved over to dagger names
]);
::Const.Strings.CrossbowNames.extend([
	"Scorpion",
	"Ironsight",
	"Thunderbolt",
	"Ravenshrike",
	"Bloodbolt",
	"Grimshot",
	"Wyrmfang",
	"Blackthorn",
	"Stormbreaker",
	"Steelwind"
]);

::MSU.Array.removeValues(::Const.Strings.DaggerNames, [
	"Estoc"		// We have our own actual Estoc item
]);
::Const.Strings.DaggerNames.extend([
	"Betrayer"		// formerly a crossbow name
]);

::Const.Strings.HandgonneNames.extend([
	"Deafener",
	"Eisenknall",
	"Volcano",
	"Ironspark",
	"Thundermuzzle",
	"Stormfire",
	"Inferno",
	"Blazeburst"
]);

::Const.Strings.LongaxeNames.extend([
	"Culler"
]);

::Const.Strings.SwordlanceNames.extend([	// In Vanilla this has only 2 entries
	"Bloodmoon",
	"Ghoul\'s Bane",
	"Soulstrike",
	"Shadowreaper",
	"Death\'s Hand",
	"Grimharvest",
	"Bloodstorm",
	"Warbringer",
	"Deathwind"
]);

::MSU.Array.removeValues(::Const.Strings.WarbrandNames, [
	"Kriegsmesser",	// We have our own actual Kriegsmesser item
]);

::Const.Strings.WhipNames.extend([
	"Slavedriver",
	"Tendril",
	"Vine",
	"Bloodletter",
	"Spikelash",
	"Thornwhip",
	"Bloodlash"
]);

// Reforged Lists
::Const.Strings.RF_KriegsmesserNames <- [
	"Kriegsmesser",
	"Ripper",
	"Slicer",
	"Cutter",
	"Beheader",
	"Ravager",
	"Bloodspiller",
	"Bloodthirster",
	"Madness",
	"Carver",
	"War Cleaver",
	"Lacerator",
	"Mangler",
	"Gasher",
	"Mutilator",
	"Maimer",
	"Tormentor",
	"Render",
	"Beidhander",
	"Blade",
	"Longblade",
	"Slayer",
	"Vanquisher",
	"Beheader",
	"Calamity",
	"Fleshripper",
	"Fleshrender"
];

::Const.Strings.RF_LongswordNames <- [
	"Slasher",
	"Slicer",
	"Blade",
	"Cutter",
	"Sword",
	"Deathdealer",
	"Mercy",
	"Slayer",
	"Edge",
	"Warblade",
	"Longblade",
	"Bloodspiller",
	"Oathkeeper",
	"Glimmer",
	"Reckoning",
	"Avenger",
	"Red Rivers",
	"Stinger",
	"Lightning",
	"Striker",
	"Razor",
	"Edge",
	"Windblade",
	"Swiftblade",
	"Carver",
	"Vengeance",
	"Honor",
	"Vanquisher"
];
