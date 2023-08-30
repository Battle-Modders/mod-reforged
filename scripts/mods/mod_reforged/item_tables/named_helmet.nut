::Reforged.ItemTable.NamedHelmet <- ::ItemTables.Class.ItemTable([
	[1, "scripts/items/helmets/named/norse_helmet"],
	[1, "scripts/items/helmets/named/named_steppe_helmet_with_mail"],
	[1, "scripts/items/helmets/named/named_metal_skull_helmet"],
	[1, "scripts/items/helmets/named/named_metal_nose_horn_helmet"],
	[1, "scripts/items/helmets/named/red_and_gold_band_helmet"],
	[1, "scripts/items/helmets/named/named_nordic_helmet_with_closed_mail"],
	[1, "scripts/items/helmets/named/named_conic_helmet_with_faceguard"],
	[1, "scripts/items/helmets/named/gold_and_black_turban"],
	[1, "scripts/items/helmets/named/named_metal_bull_helmet"]
]);

foreach (script in ::Const.Items.NamedHelmets)
{
	::Reforged.ItemTable.NamedHelmet.add(script, 1);
}
