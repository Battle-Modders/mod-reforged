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

// Remove Kriegsmesser from Warbrand names because we have our own actual Kriegsmesser item
::MSU.Array.removeByValue(::Const.Strings.WarbrandNames, "Kriegsmesser");
