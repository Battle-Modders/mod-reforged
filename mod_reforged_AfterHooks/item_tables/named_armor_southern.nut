::Reforged.ItemTable.NamedArmorSouthern <- ::ItemTables.Class.ItemTable();

foreach (script in ::Const.Items.NamedSouthernArmors)
{
	::Reforged.ItemTable.NamedArmorSouthern.add("scripts/items/" + script, 1);
}
