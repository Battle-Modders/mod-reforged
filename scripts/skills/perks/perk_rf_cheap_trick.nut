this.perk_rf_cheap_trick <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_cheap_trick";
		this.m.Name = ::Const.Strings.PerkName.RF_CheapTrick;
		this.m.Description = ::Const.Strings.PerkDescription.RF_CheapTrick;
		this.m.Icon = "ui/perks/perk_rf_cheap_trick.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_cheap_trick_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_cheap_trick");
	}
});
