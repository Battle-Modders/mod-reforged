this.perk_rf_swordmaster_juggernaut <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_juggernaut";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterJuggernaut;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterJuggernaut;
		this.m.Icon = "ui/perks/rf_swordmaster_juggernaut.png";
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		local ret = this.perk_rf_swordmaster_abstract.isEnabled();
		if (ret)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon.isItemType(::Const.Items.ItemType.RF_Fencing) || !weapon.isItemType(::Const.Items.ItemType.TwoHanded)) return false;
		}

		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_charge_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_swordmaster_charge");
	}
});
