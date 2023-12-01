::Reforged.ItemTable.NamedArmorSouthern <- ::ItemTables.Class.ItemTable([
	[1, "scripts/items/armor/named/named_golden_lamellar_armor"]
]);

foreach (script in ::Const.Items.NamedSouthernArmors)
{
	::Reforged.ItemTable.NamedArmorSouthern.add("scripts/items/" + script, 1);
}
