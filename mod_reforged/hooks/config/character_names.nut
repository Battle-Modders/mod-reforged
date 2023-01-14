
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

// This will also void any custom names from other mods that execute before Reforged
::Const.Strings.KnightNames = [];

local knightPrefix = "Sir ";
foreach(characterName in ::Const.Strings.CharacterNames)
{
    ::Const.Strings.KnightNames.push(knightPrefix + characterName);
}
