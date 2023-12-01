::Reforged.ItemTable.NamedHelmetBarbarian <- ::ItemTables.Class.ItemTable();

foreach (script in ::Const.Items.NamedBarbarianHelmets)
{
	::Reforged.ItemTable.NamedHelmetBarbarian.add("scripts/items/" + script, 1);
}
