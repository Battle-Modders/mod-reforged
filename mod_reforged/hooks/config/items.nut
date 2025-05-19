::Const.Items.addNewItemType("RF_Fencing", "Fencing Item");
::Const.Items.addNewItemType("RF_Southern", "Southern");

local namedMeleeWeapons = [
	"weapons/named/named_rf_battle_axe",
	"weapons/named/named_rf_estoc",
	"weapons/named/named_rf_poleflail",
	"weapons/named/named_rf_swordstaff",
	"weapons/named/named_rf_kriegsmesser",
	"weapons/named/named_rf_longsword",
	"weapons/named/named_rf_poleaxe",
	"weapons/named/named_rf_voulge"
];

::Const.Items.NamedMeleeWeapons.extend(namedMeleeWeapons);
::Const.Items.NamedWeapons.extend(namedMeleeWeapons);
