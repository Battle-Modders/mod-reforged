::Reforged.ItemTable.NamedHelmetSouthern <- ::ItemTables.Class.ItemTable();

foreach (script in ::Const.Items.NamedSouthernHelmets)
{
	::Reforged.ItemTable.NamedHelmetSouthern.add("scripts/items/" + script, 1);
}
