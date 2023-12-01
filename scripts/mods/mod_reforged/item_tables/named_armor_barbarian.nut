::Reforged.ItemTable.NamedArmorBarbarian <- ::ItemTables.Class.ItemTable();

foreach (script in ::Const.Items.NamedBarbarianArmors)
{
	::Reforged.ItemTable.NamedArmorBarbarian.add("scripts/items/" + script, 1);
}
