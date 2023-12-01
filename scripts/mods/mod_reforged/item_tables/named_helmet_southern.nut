::Reforged.ItemTable.NamedHelmetSouthern <- ::ItemTables.Class.ItemTable([
	[1, "scripts/items/helmets/named/named_steppe_helmet_with_mail"]
]);

foreach (script in ::Const.Items.NamedSouthernHelmets)
{
	::Reforged.ItemTable.NamedHelmetSouthern.add("scripts/items/" + script, 1);
}
