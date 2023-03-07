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

// Remove Kriegsmesser from Warbrand names because we have our own actual Kriegsmesser item
::MSU.Array.removeByValue(::Const.Strings.WarbrandNames, "Kriegsmesser");
