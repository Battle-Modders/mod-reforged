::Reforged.ItemTable.NamedArmor <- ::ItemTables.Class.ItemTable([
	[1, "scripts/items/armor/named/named_plated_fur_armor"],
	[1, "scripts/items/armor/named/named_noble_mail_armor"],
	[1, "scripts/items/armor/named/named_skull_and_chain_armor"],
	[1, "scripts/items/armor/named/black_and_gold_armor"],
	[1, "scripts/items/armor/named/lindwurm_armor"],
	[1, "scripts/items/armor/named/named_sellswords_armor"],
	[1, "scripts/items/armor/named/named_bronze_armor"],
	[1, "scripts/items/armor/named/named_golden_lamellar_armor"],
	[1, "scripts/items/armor/named/leopard_armor"],
]);

foreach (script in ::Const.Items.NamedArmors)
{
	::Reforged.ItemTable.NamedArmor.add(script, 1);
}
