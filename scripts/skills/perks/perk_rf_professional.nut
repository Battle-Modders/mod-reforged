this.perk_rf_professional <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_professional";
		this.m.Name = ::Const.Strings.PerkName.RF_Professional;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Professional;
		this.m.Icon = "ui/perks/rf_professional.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_death_dealer", function(o) {
			o.m.IsSerialized = false;
			o.m.IsRefundable = false;
		}));
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_shield_expert", function(o) {
			o.m.IsSerialized = false;
			o.m.IsRefundable = false;
		}));
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_formidable_approach", function(o) {
			o.m.IsSerialized = false;
			o.m.IsRefundable = false;
		}));
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_duelist", function(o) {
			o.m.IsSerialized = false;
			o.m.IsRefundable = false;
		}));
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_weapon_master", function(o) {
			o.m.IsSerialized = false;
			o.m.IsRefundable = false;
		}));

		if (this.m.IsNew)
		{
			local perkTree = this.getContainer().getActor().getPerkTree();

			perkTree.addPerk("perk.rf_death_dealer", 2);
			perkTree.addPerk("perk.shield_expert", 3);
			perkTree.addPerk("perk.rf_formidable_approach", 3);
			perkTree.addPerk("perk.duelist", 6);
			perkTree.addPerk("perk.rf_weapon_master", 7);
		}
	}

	function onRemoved()
	{
		this.getContainer().removeByStackByID("perk.rf_death_dealer", false);
		this.getContainer().removeByStackByID("perk.shield_expert", false);
		this.getContainer().removeByStackByID("perk.rf_formidable_approach", false);
		this.getContainer().removeByStackByID("perk.duelist", false);
		this.getContainer().removeByStackByID("perk.rf_weapon_master", false);
	}
});
