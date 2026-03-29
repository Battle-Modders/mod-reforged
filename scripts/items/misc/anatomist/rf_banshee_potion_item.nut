this.rf_banshee_potion_item <- ::inherit("scripts/items/misc/anatomist/rf_anatomist_potion_item", {
	m = {},
	function create()
	{
		this.rf_anatomist_potion_item.create();
		this.m.ID = "misc.rf_banshee_potion";
		this.m.Name = "Potion of Serenity";
		local entityName = ::Const.Strings.EntityName[::Const.EntityType.RF_Banshee];
		entityName = ::Const.Strings.getArticle(entityName) + entityName;
		// Text generated and edited by LordMidas using Gemini
		this.m.Description = "A thin, shimmering distillate refined from the spectral residue of " + entityName + ". The fluid is deceptively light, almost weightless in the hand, and carries a sharp stinging scent. Clinical trials indicate that the brew stabilizes the subject\'s humors, aligning their temperament toward a constant state of positivity. This ensures the drinker is not only more resilient against terror or grief, but also more likely to ascend into a state of inspired confidence. Subjects report a persistent, phantom ringing in their ears for a few days after ingestion that subsides with time but never really goes away.";
		this.m.Icon = "consumables/rf_banshee_potion_item.png";
	}
});
