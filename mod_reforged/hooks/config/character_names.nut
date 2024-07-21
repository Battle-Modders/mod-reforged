::Const.Strings.RF_VampireLordNames <- [
	"Cynfael",
	"Duradel",
	"Auberon",
	"Lestat",
	"Ichabod",
	"Mortas",
	"Draven",
	"Dregan",
	"Zadimus"
	"Malachi",
	"Davorin",
	"Raphael",
	"Melchior"
	"Vladimir",
	"Zaros",
	"Orpheus"
];
::Const.Strings.RF_VampireLordTitles <- [
	"the Impaler",
	"the Immortal",
	"the Everliving",
	"the Bloodletter",
	"the Deathless",
	"the Crimson"
	"the Scourge",
	"the Nightmare",
	"the Terror",
	"the Devil",
	"the Fiend",
	"the Demon",
	"the Sadist",
	"the Vicious"
];
::Const.Strings.RF_AncientDeadCommanderTitles <- [
	"the Returned",
	"the Restorator",
	"the Ancient",
	"the Destroyer",
	"the Herald",
	"the Unearthed",
	"the Honored",
	"the Defender",
	"the Glorious",
	"the Favored"
];

::Const.Strings.RF_ManAtArmsTitles <- [
	"the Bull of %factionname%",
	"the Shield of %factionname%",
	"the Sword of %factionname%",
	"the Hammer of %factionname% ",
	"the Hero of %factionname% ",
	"the Butcher",
	"the Ox",
	"the Bear",
	"the Proud",
	"the Hero",
	"the Brave",
	"Steelwielder",
	"Orcslayer",
	"the Greenskins\' Bane",
	"the Crusader",
	"the Indestructable",
	"the Bitter Blade",
	"Bittersteel",
	"the Lion",
	"the Courageous",
	"Brightblade",
	"the Gallant",
	"the Oathkeeper",
	"the Undefeated",
	"Ironborn"
];

::Const.Strings.RF_FencerTitles <- [
	"the Proud",
	"the Hero",
	"the Brave",
	"the Butcher",
	"Steelwielder",
	"the Sword of %factionname%",
	"the Hero of %factionname% ",
	"the Proud",
	"the Bitter Blade",
	"Bittersteel",
	"the Wolf",
	"the Courageous",
	"Brightblade",
	"the Quick",
	"Quickblade",
	"the Thorn",
	"the Heartpiercer",
	"the Skewer",
	"Longblade",
	"the Oathkeeper",
	"the Falcon",
	"the Hawk",
	"the Eagle",
	"the Blade of %factionname% ",
	"the Singing Blade"
];
::Const.Strings.RF_ZweihanderTitles <- [
	"the Butcher",
	"the Ox",
	"the Bear",
	"the Bull of %factionname%",
	"the Proud",
	"the Hero",
	"the Brave",
	"the Butcher",
	"Steelwielder",
	"the Shield of %factionname%",
	"the Sword of %factionname%",
	"the Hero of %factionname% ",
	"the Proud",
	"Orcslayer",
	"the Greenskin's Bane",
	"the Crusader",
	"the Undefeated",
	"the Bitter Blade",
	"Bittersteel",
	"the Lion",
	"the Courageous",
	"Brightblade",
	"the Gallant",
	"the Oathkeeper",
	"the Singing Blade",
	"the Whirlwind",
	"the Tempest",
	"Coldsteel",
	"Ironborn"
];
::Const.Strings.CharacterNames.extend([
    "Agnar",
    "Alard",
    "Alaric",
    "Albert",
    "Albterus",
    "Aldwin",
    "Ansgar",
    "Badulf",
    "Baldarich",
    "Baldo",
    "Baldovin",
    "Baldwin",
    "Baranor",
    "Bertilo",
    "Bjorn",
    "Brando",
    "Burchard",
    "Carolus",
    "Cenric",
    "Conrad",
    "Dagfinn",
    "Dunstan",
    "Eckhart",
    "Edgar",
    "Egino",
    "Elof",
    "Emelrich",
    "Eswig",
    "Faramund",
    "Farvald",
    "Filibert",
    "Franco",
    "Friduhelm",
    "Gaufrid",
    "Gautvin",
    "Gerbold",
    "Gilbert",
    "Giselbert",
    "Gismund",
    "Godric",
    "Grimm",
    "Hadubert",
    "Hagano",
    "Harold",
    "Hartwin",
    "Heidrich",
    "Helmfried",
    "Helmo",
    "Helmut",
    "Herman",
    "Kuno",
    "Lambert",
    "Landulf",
    "Lanzo",
    "Leofric",
    "Leonard",
    "Leudagar",
    "Leuthar",
    "Leutwin",
    "Manno",
    "Meino",
    "Meinrad",
    "Milo",
    "Norbert",
    "Odo",
    "Olvir",
    "Oswin",
    "Pipin",
    "Randulf",
    "Regin",
    "Reinald",
    "Reinhard",
    "Richard",
    "Roland",
    "Sigimar",
    "Silvan",
    "Siward",
    "Svenn",
    "Theo",
    "Theodar",
    "Thiemo",
    "Valdemar",
    "Veremund",
    "Waldo",
    "Waldomar",
    "Walther",
    "Widald",
    "Wido",
    "Wigand",
    "Wighart",
    "Wilfred",
    "Wolfhart",
    "Wulfric"
]);

// This removes all duplicate CharacterNames. This line is redundant for Vanilla + Reforged because our additional names are already checked for duplicates
// Any mod that adds names after ours may re-introduce duplicates. This is not game-breaking but still undeLorded
::Const.Strings.CharacterNames = ::MSU.Array.removeDuplicates(::Const.Strings.CharacterNames);

foreach(characterName in ::Const.Strings.CharacterNames)
{
    ::Const.Strings.KnightNames.push("Sir " + characterName);
}

// This removes all duplicate KnightNames. This is important because Vanilla has KnightNames that also exist as CharacterNames.
::Const.Strings.KnightNames = ::MSU.Array.removeDuplicates(::Const.Strings.KnightNames);
::Const.Strings.RF_KnightAnointedNames <- ::Const.Strings.KnightNames.map(@(name) ::String.replace(name, "Sir", "Lord"));

// Remove The Robber Baron as a bandit leader name because we have a RobberBaron entity in Reforged
::MSU.Array.removeByValue(::Const.Strings.BanditLeaderNames, "The Robber Baron");

::Const.Strings.SouthernNames.extend([
	"Adil",
	"Akil",
	"Akram",
	"Amin",
	"Anwar",
	"Asim",
	"Badr",
	"Bashir",
	"Fahad",
	"Faisal",
	"Farid",
	"Ghassan",
	"Habib",
	"Hadi",
	"Hakim",
	"Harith",
	"Idris",
	"Ihsan",
	"Imad",
	"Imran",
	"Ishaq",
	"Jafar",
	"Jamal",
	"Jibril",
	"Karim",
	"Khalid",
	"Khalil",
	"Latif",
	"Layth",
	"Mahdi",
	"Mahir",
	"Marwan",
	"Munir",
	"Nadir",
	"Najeeb",
	"Naji",
	"Nawfal",
	"Qadir",
	"Qasim",
	"Qays",
	"Rafiq",
	"Saad",
	"Safwan",
	"Salah",
	"Salim",
	"Samir",
	"Suhayl",
	"Talib",
	"Thabit",
	"Wahid",
	"Waqas",
	"Yasir",
	"Zafar",
	"Zayd",
	"Zeeshan",
	"Ziyad",
	"Zuhayr",
	"Zahid",
	"Zubayr"
]);

// The array contains some duplicates even in vanilla
::Const.Strings.SouthernNames = ::MSU.Array.removeDuplicates(::Const.Strings.SouthernNames);

foreach (i, name in ::Const.Strings.SouthernNames)
{
	::Const.Strings.SouthernNamesLast.push("Ibn " + name);
	::Const.Strings.SouthernNamesLast.push("Al-" + name);
	// For Officer Titles we push all Al- variants but fewer Ibn variants
	// and a small number of long variants of the form "Al-Name Ibn Name"
	// this is similar to the distribution of vanilla SouthernOfficerTitles
	::Const.Strings.SouthernOfficerTitles.push("Al-" + name);
	if (i % 3 == 0)
	{
		::Const.Strings.SouthernOfficerTitles.push("Ibn " + name);
	}
	if (i % 5 == 0)
	{
		::Const.Strings.SouthernOfficerTitles.push("Al-" + name + " Ibn " + ::MSU.Array.rand(::Const.Strings.SouthernNames));
	}
}

::Const.Strings.SouthernNamesLast = ::MSU.Array.removeDuplicates(::Const.Strings.SouthernNamesLast);
::Const.Strings.SouthernOfficerTitles = ::MSU.Array.removeDuplicates(::Const.Strings.SouthernOfficerTitles);
