// Version of the greatsword_faction_helm without faction-colored ribbon. The art for this exists in vanilla but is unused.
this.rf_greatsword_helm <- ::inherit("scripts/items/helmets/greatsword_faction_helm", {
	m = {},
	function create()
	{
		this.greatsword_faction_helm.create();
		this.m.ID = "armor.head.rf_greatsword_helm";
		// We name it Duelist's Helmet instead of the vanilla Zweihander's Helmet to be in
		// line with being a heavier version of the vanilla Duelist's Hat (greatsword_hat).
		this.m.Name = "Duelist\'s  Helmet";
		this.m.Variant = 82;
		this.m.VariantString = "helmet";
		this.updateVariant();
	}

	// Overwrite updateVariant function of greatsword_faction_helm because that has custom logic
	function updateVariant()
	{
		this.helmet.updateVariant();
	}
});
