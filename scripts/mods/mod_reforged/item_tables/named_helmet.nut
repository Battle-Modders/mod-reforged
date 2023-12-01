::Reforged.ItemTable.NamedHelmet <- ::ItemTables.Class.ItemTable();

foreach (script in ::Const.Items.NamedHelmets)
{
	::Reforged.ItemTable.NamedHelmet.add("scripts/items/" + script, 1);
}
