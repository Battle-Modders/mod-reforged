this.rf_banshee_potion_item <- ::inherit("scripts/items/misc/anatomist/rf_anatomist_potion_item", {
	m = {},
	function create()
	{
		this.rf_anatomist_potion_item.create();
		this.m.ID = "misc.rf_banshee_potion";
		this.m.Name = "Potion of Serenity";
		local entityName = ::Const.Strings.EntityName[::Const.EntityType.RF_Banshee];
		entityName = ::Const.Strings.getArticle(entityName) + entityName;
		this.m.Description = "Developed from the crystallized essence of " + entityName + ", this concoction alters a man\'s mind to be far more resistant against negative emotions while strengthening positive ones.";
		this.m.Icon = "consumables/rf_banshee_potion_item.png";
	}
});
