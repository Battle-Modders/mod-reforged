::Reforged.ItemTable.NamedArmor <- ::ItemTables.Class.ItemTable();

foreach (script in ::Const.Items.NamedArmors)
{
	::Reforged.ItemTable.NamedArmor.add("scripts/items/" + script, 1);
}
